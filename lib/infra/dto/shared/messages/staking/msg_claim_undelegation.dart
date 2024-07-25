import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
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
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufString(sender),
      2: ProtobufInt64(undelegationId),
    });
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
