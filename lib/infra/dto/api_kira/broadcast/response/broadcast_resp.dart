import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_tx.dart';

class BroadcastResp {
  final BroadcastTx checkTx;
  final BroadcastTx deliverTx;
  final String hash;
  final String height;

  BroadcastResp({
    required this.checkTx,
    required this.deliverTx,
    required this.hash,
    required this.height,
  });

  factory BroadcastResp.fromJson(Map<String, dynamic> json) {
    return BroadcastResp(
      checkTx: BroadcastTx.fromJson(json['check_tx'] as Map<String, dynamic>),
      deliverTx: BroadcastTx.fromJson(json['deliver_tx'] as Map<String, dynamic>),
      hash: json['hash'] as String,
      height: json['height'] as String,
    );
  }

  @override
  String toString() {
    return 'BroadcastResp{checkTx: $checkTx, deliverTx: $deliverTx, hash: $hash, height: $height}';
  }
}
