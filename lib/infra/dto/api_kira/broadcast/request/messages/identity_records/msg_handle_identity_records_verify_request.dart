import 'package:miro/infra/dto/api_kira/broadcast/request/messages/a_tx_msg.dart';

/// MsgHandleIdentityRecordsVerifyRequest defines a proposal
/// message to approve or reject an identity record request
class MsgHandleIdentityRecordsVerifyRequest extends ATxMsg {
  /// The address of verifier
  final String verifier;

  /// The id of verification request
  final BigInt verifyRequestId;

  /// Defines approval or rejecting an identity request
  final bool yes;

  const MsgHandleIdentityRecordsVerifyRequest({
    required this.verifier,
    required this.verifyRequestId,
    required this.yes,
  }) : super(
          messageType: '/kira.gov.MsgHandleIdentityRecordsVerifyRequest',
          signatureMessageType: 'kiraHub/MsgHandleIdentityRecordsVerifyRequest',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'verifier': verifier,
      'verify_request_id': verifyRequestId.toString(),
      'yes': yes,
    };
  }

  @override
  List<Object?> get props => <Object?>[verifier, verifyRequestId, yes];
}
