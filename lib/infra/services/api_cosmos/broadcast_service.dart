import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IBroadcastService {
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel);
}

class BroadcastService implements _IBroadcastService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    BroadcastReq broadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(signedTransactionModel));
    try {
      final Response<dynamic> response = await _apiCosmosRepository.broadcast<dynamic>(networkUri, broadcastReq);
      BroadcastResp broadcastResp = BroadcastResp.fromJson(response.data as Map<String, dynamic>);
      return BroadcastRespModel(hash: broadcastResp.hash);
    } on DioError catch (e) {
      AppLogger().log(message: 'BroadcastService: Cannot fetch broadcastTx for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(message: 'BroadcastService: Cannot parse broadcastTx for URI $networkUri: ${e}');
      rethrow;
    }
  }
}
