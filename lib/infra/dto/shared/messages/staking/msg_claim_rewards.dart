import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
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
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, sender),
    ]);
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
