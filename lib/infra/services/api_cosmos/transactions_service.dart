import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/transaction_sign_request.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/unsafe_wallet.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/transaction_signer.dart';

abstract class _TransactionsService {
  /// Throws [DioError]
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri});

  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction, {Uri? customUri});

  Future<TransactionNetworkData> getTransactionNetworkData({Uri? customUri, String? customChainId});
}

class TransactionsService implements _TransactionsService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri}) async {
    Uri networkUri = customUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      Response<Map<String, dynamic>> response = await _apiCosmosRepository.broadcast(
        networkUri,
        BroadcastReq(
          transaction: signedTransaction,
        ),
      );
      final BroadcastResp broadcastResp = BroadcastResp.fromJson(response.data as Map<String, dynamic>);
      if (broadcastResp.checkTx.data == null) {
        throw DioError(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
      return broadcastResp;
    } on DioError catch (e) {
      AppLogger().log(message: '${signedTransaction.toJson()} - ${e.response}', logLevel: LogLevel.error);
      rethrow;
    }
  }

  @override
  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction,
      {Uri? customUri, String? customChainId}) async {
    final Wallet? wallet = globalLocator<WalletProvider>().currentWallet;
    TransactionNetworkData transactionNetworkData = await getTransactionNetworkData(
      customUri: customUri,
      customChainId: customChainId,
    );

    assert(wallet is UnsafeWallet, 'User should be logged via UnsafeWallet');

    SignedTransaction signedTransaction = TransactionSigner.sign(
      unsignedTransaction: unsignedTransaction,
      transactionNetworkData: transactionNetworkData,
      ecPrivateKey: (wallet as UnsafeWallet).ecPrivateKey,
      ecPublicKey: wallet.ecPublicKey,
    );

    return signedTransaction;
  }

  @override
  Future<TransactionNetworkData> getTransactionNetworkData({Uri? customUri, String? customChainId}) async {
    final NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    final QueryAccountService accountService = globalLocator<QueryAccountService>();
    final Wallet? wallet = globalLocator<WalletProvider>().currentWallet;

    assert(wallet != null, 'User should be logged in');
    assert(networkProvider.isConnected || customUri != null, 'Network should be connected');

    QueryAccountResp queryAccountResp = await accountService.fetchQueryAccount(
      wallet!.address.bech32Address,
      customUri: customUri,
    );

    return TransactionNetworkData(
      sequence: queryAccountResp.sequence ?? '0',
      accountNumber: queryAccountResp.accountNumber,
      chainId: customChainId ?? networkProvider.networkModel!.queryInterxStatus!.interxInfo.chainId,
    );
  }
}
