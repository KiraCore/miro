import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';

class BroadcastRespModel extends Equatable {
  final String hash;

  const BroadcastRespModel({
    required this.hash,
  });

  factory BroadcastRespModel.fromDto(BroadcastResp broadcastResp) {
    return BroadcastRespModel(
      hash: broadcastResp.hash,
    );
  }

  @override
  List<Object?> get props => <Object>[hash];
}
