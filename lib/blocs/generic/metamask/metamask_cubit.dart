import 'dart:convert';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/flutter_web3.dart' hide Wallet;
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

part 'metamask_state.dart';

class MetamaskCubit extends Cubit<MetamaskState> {
  final BroadcastService _broadcastService;

  // TODO(Mykyta): fix parameters once INTERX supports Eth chain for MetaMask
  static const int _kiraChainId = 1;
  static const String _kiraChainName = 'Kira Testnet';
  static const String _kiraRpcUrl = 'https://kira-rpc.kira.network';
  static const String _kiraNativeCurrencyName = 'Kira';
  static const String _kiraNativeCurrencySymbol = 'Kira';
  static const int _kiraNativeCurrencyDecimals = 18;

  final AuthCubit _authCubit;
  final EthereumProvider _ethereumProvider;

  MetamaskCubit()
      : _authCubit = globalLocator<AuthCubit>(),
        _ethereumProvider = globalLocator<EthereumProvider>(),
        _broadcastService = globalLocator<BroadcastService>(),
        super(const MetamaskState());

  @override
  Future<void> close() {
    _ethereumProvider.removeAllListeners();
    return super.close();
  }

  bool get isSupported => _ethereumProvider.isSupported;

  void init() {
    if (isSupported == false) {
      return;
    }
    _ethereumProvider
      ..removeAllListeners()
      ..handleConnect((ConnectInfo connectInfo) {
        AppLogger().log(message: 'handleConnect: $connectInfo', logLevel: LogLevel.debug);

        _handleChainChanged(int.parse(connectInfo.chainId, radix: 16));
      })
      ..handleDisconnect((ProviderRpcError error) {
        AppLogger().log(message: 'Metamask disconnect: $error', logLevel: LogLevel.warning);

        _signOut();
      })
      ..handleAccountsChanged(_handleAccountsChanged)
      ..handleChainChanged(_handleChainChanged);
  }

  Future<void> connect() async {
    if (isSupported == false) {
      return;
    }
    List<String>? accounts;
    int? chainId;
    try {
      accounts = await _ethereumProvider.requestAccount();
      chainId = await _ethereumProvider.getChainId();
    } catch (e) {
      AppLogger().log(message: 'Error on metamask connect: $e', logLevel: LogLevel.error);
    }

    if (accounts?.isEmpty != false || chainId == null) {
      await _signOut();
      return;
    }
    await _switchNetworkToKira();

    await _signIn(address: accounts!.first, chainId: chainId);
  }

  void resetState() {
    _ethereumProvider.removeAllListeners();
    emit(const MetamaskState());
  }

  // TODO(Mykyta): to be implemented in future task for MetaMask Pay feature with Cosmos signing
  Future<void> pay({required AWalletAddress to, required int amount}) async {
    if (isSupported == false || state.isConnected == false) {
      return;
    }
    await _switchNetworkToKira();
    String ethereumFromAddress = to is CosmosWalletAddress ? to.toEthereumAddress() : to.address;

    CosmosWalletAddress cosmosToAddress = to is EthereumWalletAddress ? to.toOppositeAddressType() as CosmosWalletAddress : to as CosmosWalletAddress;
    CosmosWalletAddress cosmosFromAddress = _authCubit.state!.address is EthereumWalletAddress
        ? (_authCubit.state!.address as EthereumWalletAddress).toOppositeAddressType() as CosmosWalletAddress
        : _authCubit.state!.address as CosmosWalletAddress;
    try {
      const TxRemoteInfoModel txRemoteInfoModel = TxRemoteInfoModel(
        accountNumber: '669',
        chainId: 'testnet-9',
        sequence: '0',
      );

      final Map<String, dynamic> tx = (await _ethereumProvider.signTransaction(
        ethereumFromAddress,
        <String, dynamic>{
          'msg': <Map<String, Object>>[
            <String, Object>{
              'type': 'cosmos-sdk/MsgSend',
              'value': <String, Object>{
                'from_address': cosmosFromAddress.address,
                'to_address': cosmosToAddress.address,
                'amount': <Map<String, String>>[
                  <String, String>{'denom': 'ukex', 'amount': '500'}
                ]
              }
            }
          ],
          'fee': <String, Object>{
            'amount': <Map<String, String>>[
              <String, String>{'denom': 'ukex', 'amount': '200'}
            ],
            'gas': '200000',
          },
          'memo': 'Test transaction',
          'chain_id': txRemoteInfoModel.chainId,
          'sequence': txRemoteInfoModel.sequence,
          'account_number': txRemoteInfoModel.accountNumber,
        },
      )) as Map<String, dynamic>;

      final SignedTxModel signedTransactionModel = SignedTxModel(
        signedCosmosTx: CosmosTx.signed(
          body: CosmosTxBody(
            messages: <ProtobufAny>[
              MsgSend(
                fromAddress: cosmosFromAddress.address,
                toAddress: cosmosToAddress.address,
                amount: <CosmosCoin>[
                  CosmosCoin(denom: 'ukex', amount: BigInt.from(500)),
                ],
              ),
            ],
            memo: tx['memo'] as String,
          ),
          authInfo: CosmosAuthInfo(
            signerInfos: <CosmosSignerInfo>[
              CosmosSignerInfo(
                publicKey: CosmosSimplePublicKey(base64Decode((((tx['signatures'] as List)[0] as Map)['pub_key'] as Map<String, String>)['value'] as String)),
                modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
                sequence: int.parse(txRemoteInfoModel.sequence),
              ),
            ],
            fee: CosmosFee(
              amount: <CosmosCoin>[
                CosmosCoin(amount: BigInt.from(int.parse((((tx['fee'] as Map)['amount'] as List)[0] as Map)['amount'] as String)), denom: 'ukex')
              ],
              gasLimit: BigInt.from(200000),
            ),
          ),
          signatures: <CosmosSignature>[
            CosmosSignature(
              r: BigInt.from(((tx['signatures'] as List)[0] as Map)['r'] as int),
              s: BigInt.from(((tx['signatures'] as List)[0] as Map)['s'] as int),
            )
          ],
        ),
        txLocalInfoModel: TxLocalInfoModel(
          memo: tx['memo'] as String,
          feeTokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.one,
            tokenAliasModel: const TokenAliasModel(
              name: 'Kira',
              defaultTokenDenominationModel: TokenDenominationModel(name: 'Kira', decimals: 18),
              networkTokenDenominationModel: TokenDenominationModel(name: 'Kira', decimals: 18),
            ),
          ),
          txMsgModel: MsgSendModel(
            fromWalletAddress: cosmosFromAddress,
            toWalletAddress: cosmosToAddress,
            tokenAmountModel: TokenAmountModel(
              defaultDenominationAmount: Decimal.one,
              tokenAliasModel: const TokenAliasModel(
                name: 'Kira',
                defaultTokenDenominationModel: TokenDenominationModel(name: 'Kira', decimals: 18),
                networkTokenDenominationModel: TokenDenominationModel(name: 'Kira', decimals: 18),
              ),
            ),
          ),
        ),
        txRemoteInfoModel: txRemoteInfoModel,
      );

      emit(MetamaskState(
        signedTxModel: signedTransactionModel,
      ));

      await _broadcastService.broadcastTx(signedTransactionModel);

      // // TODO(Mykyta): remove signer and direct usage of ethereum (`send-via-metamask` task)
      // await Web3Provider.fromEthereum(ethereum!).getSigner().sendTransaction(
      //       TransactionRequest(
      //         from: state.address!,
      //         to: address,
      //         value: BigInt.from(amount),
      //       ),
      //     );
    } on TxBroadcastException catch (e) {
      AppLogger().log(
          message:
              'Error on metamask pay broadcast: ${e.broadcastErrorLogModel.code}: ${e.broadcastErrorLogModel.message} --- ${e.response.statusCode}:${e.response.data}',
          logLevel: LogLevel.error);
    } on DioParseException catch (e) {
      AppLogger().log(message: 'Error on metamask pay broadcast: ${e.error} --- ${e.response.statusCode}:${e.response.data}', logLevel: LogLevel.error);
    } catch (e) {
      AppLogger().log(message: 'Error on metamask pay: $e', logLevel: LogLevel.error);
    }
  }

  Future<void> _switchNetworkToKira() async {
    if (isSupported == false) {
      return;
    }
    try {
      await _ethereumProvider.switchWalletChain(_kiraChainId);
    } on EthereumException catch (e) {
      AppLogger().log(message: 'Error on metamask switch network: $e', logLevel: LogLevel.error);

      switch (e.code) {
        case 4902:
          // chain doesn't exist
          await _addKiraNetwork();
          break;
      }
    } catch (e) {
      AppLogger().log(message: 'Error on metamask switch network: $e', logLevel: LogLevel.error);
    }
  }

  Future<void> _addKiraNetwork() async {
    if (isSupported == false) {
      return;
    }
    try {
      await _ethereumProvider.addWalletChain(
        chainId: _kiraChainId,
        chainName: _kiraChainName,
        nativeCurrencyName: _kiraNativeCurrencyName,
        nativeCurrencySymbol: _kiraNativeCurrencySymbol,
        nativeCurrencyDecimals: _kiraNativeCurrencyDecimals,
        rpcUrl: _kiraRpcUrl,
      );
    } catch (e) {
      AppLogger().log(message: 'Error on metamask add network: $e', logLevel: LogLevel.error);
    }
  }

  Future<void> _handleAccountsChanged(List<String> accounts) async {
    AppLogger().log(message: 'handleAccountsChanged: $accounts', logLevel: LogLevel.debug);
    if (accounts.isEmpty) {
      await _signOut();
      return;
    }
    if (state.chainId != null) {
      await _signIn(address: accounts.first, chainId: state.chainId!);
    }
  }

  void _handleChainChanged(int chainId) {
    AppLogger().log(message: 'handleChainChanged: $chainId', logLevel: LogLevel.debug);
    emit(MetamaskState(
      chainId: chainId,
    ));
  }

  Future<void> _signIn({required String address, required int chainId}) async {
    try {
      Wallet wallet = Wallet(address: EthereumWalletAddress.fromString(address));
      await _authCubit.signIn(wallet, defaultAddressIsKiraBool: false);

      emit(MetamaskState(address: address, chainId: chainId));
    } catch (e) {
      await _signOut();
      AppLogger().log(message: 'Error on metamask signIn: $e', logLevel: LogLevel.error);
    }
  }

  Future<void> _signOut() async {
    try {
      resetState();
      await _authCubit.signOut();
    } catch (e) {
      AppLogger().log(message: 'Error on _signOut: $e', logLevel: LogLevel.error);
    }
  }
}
