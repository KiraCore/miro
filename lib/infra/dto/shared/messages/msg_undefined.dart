import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgUndefined extends ATxMsg {
  const MsgUndefined()
      : super(
          messageType: '',
          signatureMessageType: '',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{};
  }

  @override
  List<Object?> get props => <Object?>[];
}
