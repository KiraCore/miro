import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/tx.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class _IBroadcastService {
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel);
}

class BroadcastService implements _IBroadcastService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<BroadcastRespModel> broadcastTx(SignedTxModel signedTransactionModel) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    BroadcastReq broadcastReq = BroadcastReq(tx: Tx.fromSignedTxModel(signedTransactionModel));

    Response<dynamic> response = await _apiKiraRepository.broadcast<dynamic>(networkUri, broadcastReq);

    late BroadcastRespModel broadcastRespModel;
    try {
      BroadcastResp broadcastResp = BroadcastResp.fromJson(response.data as Map<String, dynamic>);
      broadcastRespModel = BroadcastRespModel.fromDto(broadcastResp);
    } catch (e) {
      AppLogger().log(message: 'BroadcastService: Cannot parse broadcastTx for URI $networkUri: ${e}');
      throw DioParseException(response: response, error: e);
    }

    if (broadcastRespModel.hasErrors) {
      throw TxBroadcastException(broadcastErrorLogModel: broadcastRespModel.broadcastErrorLogModel!, response: response);
    }

    return broadcastRespModel;
  }
}
