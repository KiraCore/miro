import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgClaimUndelegation extends ATxMsg {
  final String sender;
  final String undelegationId;

  const MsgClaimUndelegation({
    required this.sender,
    required this.undelegationId,
  }) : super(
          messageType: '/kira.multistaking.MsgClaimUndelegation',
          signatureMessageType: 'kiraHub/MsgClaimUndelegation',
        );

  factory MsgClaimUndelegation.fromJson(Map<String, dynamic> json) {
    return MsgClaimUndelegation(
      sender: json['sender'] as String,
      undelegationId: (json['undelegation_id'] as int).toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sender': sender,
      'undelegation_id': undelegationId,
    };
  }

  @override
  List<Object?> get props => <Object>[sender, undelegationId];
}
