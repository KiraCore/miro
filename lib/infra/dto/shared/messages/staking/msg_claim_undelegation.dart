import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgClaimUndelegation extends ATxMsg {
  final String sender;
  final BigInt undelegationId;

  MsgClaimUndelegation({
    required this.sender,
    required this.undelegationId,
  }) : super(typeUrl: '/kira.multistaking.MsgClaimUndelegation');

  factory MsgClaimUndelegation.fromData(Map<String, dynamic> data) {
    return MsgClaimUndelegation(
      sender: data['sender'] as String,
      undelegationId: BigInt.from(data['undelegation_id'] as int),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
      ...ProtobufEncoder.encode(2, undelegationId),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
      'undelegation_id': undelegationId.toString(),
    };
  }

  @override
  List<Object?> get props => <Object>[sender, undelegationId];
}
