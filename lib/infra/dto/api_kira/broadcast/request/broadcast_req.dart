import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class BroadcastReq extends Equatable {
  final CosmosTx tx;
  final String mode;

  const BroadcastReq({
    required this.tx,
    this.mode = 'block',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': tx.toProtoJson(),
      'mode': mode,
    };
  }

  @override
  List<Object?> get props => <Object?>[tx, mode];
}
