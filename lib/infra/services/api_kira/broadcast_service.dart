import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IBroadcastService {
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel);
}

class BroadcastService implements _IBroadcastService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    BroadcastReq broadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(signedTransactionModel));

    late Response<dynamic> response;
    try {
      response = await _apiKiraRepository.broadcast<dynamic>(networkUri, broadcastReq);
    } on DioError catch (e) {
      AppLogger().log(message: 'BroadcastService: Cannot fetch broadcastTx for URI $networkUri: ${e.message}');
      rethrow;
    }

    late BroadcastRespModel broadcastRespModel;
    try {
      BroadcastResp broadcastResp = BroadcastResp.fromJson(response.data as Map<String, dynamic>);
      broadcastRespModel = BroadcastRespModel.fromDto(broadcastResp);
    } catch (e) {
      AppLogger().log(message: 'BroadcastService: Cannot parse broadcastTx for URI $networkUri: ${e}');
      rethrow;
    }

    if (broadcastRespModel.hasErrors) {
      AppLogger().log(
        message: 'BroadcastService: <${broadcastRespModel.broadcastErrorModel?.name}> ${broadcastRespModel.broadcastErrorModel?.message}',
      );
      throw Exception('BroadcastService: Cannot broadcastTx for URI $networkUri');
    }

    return broadcastRespModel;
  }
}
