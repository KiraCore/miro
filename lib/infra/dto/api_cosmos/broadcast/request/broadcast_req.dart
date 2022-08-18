import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/tx.dart';

class BroadcastReq {
  final Tx tx;
  final String mode;

  BroadcastReq({
    required this.tx,
    this.mode = 'block',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': tx.toJson(),
      'mode': mode,
    };
  }
}
