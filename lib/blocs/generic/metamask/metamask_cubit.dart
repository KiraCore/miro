import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web3/flutter_web3.dart' hide Wallet;
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/ethereum_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

part 'metamask_state.dart';

class MetamaskCubit extends Cubit<MetamaskState> {
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
    emit(state.copyWithBool(isLoadingBool: true));
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

    if (_checkIfMetamaskPublicKeyCached(accounts!.first)) {
      await _signIn(address: accounts.first, chainId: chainId);
    } else {
      emit(MetamaskState(
        address: accounts.first,
        chainId: chainId,
        needRequestForSignaturePermissionBool: true,
        isLoadingBool: true,
      ));
    }
  }

  Future<void> resolveUserSignatureApproval({required bool isApproved}) async {
    if (state.hasData == false || state.needRequestForSignaturePermissionBool == false) {
      return;
    }
    if (isApproved) {
      emit(state.copyWithBool(isLoadingBool: true, needRequestForSignaturePermissionBool: false));
      await _signIn(address: state.address!, chainId: state.chainId!);
      emit(state.copyWithBool(isLoadingBool: false));
    } else {
      emit(state.copyWithBool(isLoadingBool: false, needRequestForSignaturePermissionBool: false));
    }
  }

  Future<void> connectAfterUserSignatureApproval() async {
    if (state.hasData == false || state.needRequestForSignaturePermissionBool == false) {
      return;
    }
    emit(state.copyWithBool(isLoadingBool: true));
    await _signIn(address: state.address!, chainId: state.chainId!);
    emit(state.copyWithBool(isLoadingBool: false));
  }

  void resetState() {
    _ethereumProvider.removeAllListeners();
    emit(const MetamaskState());
  }

  // TODO(Mykyta): to be implemented in future task for MetaMask Pay feature with Cosmos signing
  Future<void> pay({required AWalletAddress to, required int amount}) async {
    if (isSupported == false || state.hasData == false) {
      return;
    }
    await _switchNetworkToKira();
    String address;
    switch (to.runtimeType) {
      case EthereumWalletAddress:
        address = to.address;
      case CosmosWalletAddress:
        // address = to.toEthereumAddress();
        throw UnimplementedError();
      default:
        throw UnimplementedError();
    }
    try {
      // TODO(Mykyta): remove signer and direct usage of ethereum (`send-via-metamask` task)
      await Web3Provider.fromEthereum(ethereum!).getSigner().sendTransaction(
            TransactionRequest(
              from: state.address!,
              to: address,
              value: BigInt.from(amount),
            ),
          );
    } catch (e) {
      AppLogger().log(message: 'Error on metamask pay: $e', logLevel: LogLevel.error);
    }
  }

  bool _checkIfMetamaskPublicKeyCached(String ethereumAddress) {
    try {
      EthereumSignatureDecodeResult.fromDataJson(
        json.decode(globalLocator<ICacheManager>().get<String>(
          boxName: EthereumProvider.hiveBoxName,
          key: ethereumAddress.toLowerCase(),
          defaultValue: '{}',
        )) as Map<String, dynamic>,
        ethAddress: ethereumAddress,
      );
      return true;
    } catch (e) {
      return false;
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
      emit(state.copyWithBool(isLoadingBool: true));
      await _signIn(address: accounts.first, chainId: state.chainId!);
      emit(state.copyWithBool(isLoadingBool: false));
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
