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
import 'package:miro/shared/models/wallet/unsafe_wallet.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/transaction_signer.dart';

abstract class _TransactionsService {
  /// Throws [DioError]
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? optionalNetworkUri});

  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction, {Uri? optionalNetworkUri});
}

class TransactionsService implements _TransactionsService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
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
      {Uri? optionalNetworkUri, String? customChainId}) async {
    final NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    final QueryAccountService accountService = globalLocator<QueryAccountService>();
    final Wallet? wallet = globalLocator<WalletProvider>().currentWallet;

    assert(wallet != null, 'User should be logged in');
    assert(wallet is UnsafeWallet, 'User should be logged via UnsafeWallet');
    assert(networkProvider.isConnected || optionalNetworkUri != null, 'Network should be connected');

    QueryAccountResp queryAccountResp =
        await accountService.fetchQueryAccount(wallet!.address.bech32Address, optionalNetworkUri: optionalNetworkUri);
    SignedTransaction signedTransaction = TransactionSigner.sign(
      unsignedTransaction: unsignedTransaction,
      ecPrivateKey: (wallet as UnsafeWallet).ecPrivateKey,
      ecPublicKey: wallet.ecPublicKey,
      chainId: customChainId ?? networkProvider.networkModel!.queryInterxStatus!.interxInfo.chainId,
      accountNumber: queryAccountResp.accountNumber,
      sequence: queryAccountResp.sequence ?? '0',
    );

    return signedTransaction;
  }
}
