import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgClaimRewards extends ATxMsg {
  final String sender;

  const MsgClaimRewards({
    required this.sender,
  }) : super(
          messageType: '/kira.multistaking.MsgClaimRewards',
          signatureMessageType: 'kiraHub/MsgClaimRewards',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender': sender,
    };
  }

  @override
  List<Object?> get props => <Object>[sender];
}
