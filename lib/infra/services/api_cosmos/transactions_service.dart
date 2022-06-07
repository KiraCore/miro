import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/transaction_signer.dart';

abstract class _ITransactionsService {
  /// Throws [DioError]
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri});

  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction, {Uri? customUri});
}

class TransactionsService implements _ITransactionsService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<BroadcastResp> broadcastTransaction(SignedTransaction signedTransaction, {Uri? customUri}) async {
    Uri networkUri = customUri ?? globalLocator<NetworkModuleBloc>().state.networkUri;
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
  Future<SignedTransaction> signTransaction(UnsignedTransaction unsignedTransaction, {Uri? customUri, String? customChainId}) async {
    final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
    final QueryAccountService accountService = globalLocator<QueryAccountService>();
    final Wallet? wallet = globalLocator<WalletProvider>().currentWallet;

    assert(wallet != null, 'User should be logged in');
    assert(networkModuleBloc.state.isConnected || customUri != null, 'Network should be connected');

    final ANetworkOnlineModel networkOnlineModel = networkModuleBloc.state.networkStatusModel as ANetworkOnlineModel;

    QueryAccountResp queryAccountResp = await accountService.fetchQueryAccount(
      wallet!.address.bech32Address,
      customUri: customUri,
    );
    SignedTransaction signedTransaction = TransactionSigner.sign(
      unsignedTransaction: unsignedTransaction,
      ecPrivateKey: wallet.ecPrivateKey,
      ecPublicKey: wallet.ecPublicKey,
      chainId: customChainId ?? networkOnlineModel.networkInfoModel.chainId,
      accountNumber: queryAccountResp.accountNumber,
      sequence: queryAccountResp.sequence ?? '0',
    );

    return signedTransaction;
  }
}
