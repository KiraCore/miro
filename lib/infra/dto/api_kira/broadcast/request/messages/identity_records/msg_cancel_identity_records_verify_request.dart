import 'package:miro/infra/dto/api_kira/broadcast/request/messages/a_tx_msg.dart';

/// MsgEditIdentityRecord defines a proposal message to edit an identity record
class MsgCancelIdentityRecordsVerifyRequest extends ATxMsg {
  /// The address of requester
  final String executor;

  /// The id of verification request
  final BigInt verifyRequestId;

  const MsgCancelIdentityRecordsVerifyRequest({
    required this.executor,
    required this.verifyRequestId,
  }) : super(
          messageType: '/kira.gov.MsgCancelIdentityRecordsVerifyRequest',
          signatureMessageType: 'kiraHub/MsgCancelIdentityRecordsVerifyRequest',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'executor': executor,
      'verify_request_id': verifyRequestId.toString(),
    };
  }

  @override
  List<Object?> get props => <Object?>[executor, verifyRequestId];
}
