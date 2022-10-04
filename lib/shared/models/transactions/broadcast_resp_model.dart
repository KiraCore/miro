import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/shared/models/transactions/broadcast_error_model.dart';

class BroadcastRespModel extends Equatable {
  final String hash;
  final BroadcastErrorModel? broadcastErrorModel;

  const BroadcastRespModel({
    required this.hash,
    this.broadcastErrorModel,
  });

  factory BroadcastRespModel.fromDto(BroadcastResp broadcastResp) {
    BroadcastErrorModel? checkTxBroadcastErrorModel = BroadcastErrorModel.fromDto(broadcastResp.checkTx);
    BroadcastErrorModel? deliverTxBroadcastErrorModel = BroadcastErrorModel.fromDto(broadcastResp.deliverTx);

    return BroadcastRespModel(
      hash: broadcastResp.hash,
      broadcastErrorModel: checkTxBroadcastErrorModel ?? deliverTxBroadcastErrorModel,
    );
  }

  bool get hasErrors => broadcastErrorModel != null;

  @override
  List<Object?> get props => <Object>[hash];
}
