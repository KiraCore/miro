import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/tx.dart';

class BroadcastReq extends Equatable {
  final Tx tx;
  final String mode;

  const BroadcastReq({
    required this.tx,
    this.mode = 'block',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': tx.toJson(),
      'mode': mode,
    };
  }

  @override
  List<Object?> get props => <Object?>[tx, mode];
}
