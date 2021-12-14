import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/transaction_signer.dart';

abstract class _TransactionsService {
  /// Throws [DioError]
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri});

  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction, {Uri? customUri});
}

class TransactionsService implements _TransactionsService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri}) async {
    Uri networkUri = customUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final BroadcastResp response = await _apiCosmosRepository.broadcast(
        networkUri,
        BroadcastReq(
          transaction: signedTransaction,
        ),
      );
      return response;
    } on DioError catch (e) {
      AppLogger().log(message: '${signedTransaction.toJson()} - ${e.toString()}', logLevel: LogLevel.error);
      rethrow;
    }
  }

  @override
  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction,
      {Uri? customUri, String? customChainId}) async {
    final NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    final QueryAccountService accountService = globalLocator<QueryAccountService>();
    final Wallet? wallet = globalLocator<WalletProvider>().currentWallet;

    assert(wallet != null, 'User should be logged in');
    assert(networkProvider.isConnected || customUri != null, 'Network should be connected');

    QueryAccountResp queryAccountResp =
        await accountService.fetchQueryAccount(wallet!.address.bech32Address, customUri: customUri);
    SignedTransaction signedTransaction = TransactionSigner.sign(
      unsignedTransaction: unsignedTransaction,
      ecPrivateKey: wallet.ecPrivateKey,
      ecPublicKey: wallet.ecPublicKey,
      chainId: customChainId ?? networkProvider.networkModel!.queryInterxStatus!.interxInfo.chainId,
      accountNumber: queryAccountResp.accountNumber,
      sequence: queryAccountResp.sequence ?? '0',
    );

    return signedTransaction;
  }
}
