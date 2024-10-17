import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgClaimRewards extends ATxMsg {
  final String sender;

  MsgClaimRewards({
    required this.sender,
  }) : super(typeUrl: '/kira.multistaking.MsgClaimRewards');

  factory MsgClaimRewards.fromData(Map<String, dynamic> data) {
    return MsgClaimRewards(sender: data['sender'] as String);
  }

  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufString(sender),
    });
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'sender': sender,
    };
  }

  @override
  List<Object?> get props => <Object>[sender];
}
