import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';
import 'package:miro/shared/models/transactions/broadcast_error_log_model.dart';

class BroadcastRespModel extends Equatable {
  final String hash;
  final BroadcastErrorLogModel? broadcastErrorLogModel;

  const BroadcastRespModel({
    required this.hash,
    this.broadcastErrorLogModel,
  });

  factory BroadcastRespModel.fromDto(BroadcastResp broadcastResp) {
    BroadcastErrorLogModel? checkTxBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(broadcastResp.checkTx);
    BroadcastErrorLogModel? deliverTxBroadcastErrorLogModel = BroadcastErrorLogModel.fromDto(broadcastResp.deliverTx);

    return BroadcastRespModel(
      hash: broadcastResp.hash,
      broadcastErrorLogModel: checkTxBroadcastErrorLogModel ?? deliverTxBroadcastErrorLogModel,
    );
  }

  bool get hasErrors => broadcastErrorLogModel != null;

  @override
  List<Object?> get props => <Object>[hash];
}
