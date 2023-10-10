import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Proposal message to approve or reject an identity record request
/// Represents MsgHandleIdentityRecordsVerifyRequest interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgHandleIdentityRecordsVerifyRequest extends ATxMsg {
  /// The address of verifier
  final String verifier;

  /// The id of verification request
  final int verifyRequestId;

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

  factory MsgHandleIdentityRecordsVerifyRequest.fromJson(Map<String, dynamic> json) {
    return MsgHandleIdentityRecordsVerifyRequest(
      verifier: json['verifier'] as String,
      verifyRequestId: json['verify_request_id'] as int,
      yes: json['yes'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'verifier': verifier,
      'verify_request_id': verifyRequestId.toString(),
      if (yes == true) 'yes': yes,
    };
  }

  @override
  List<Object?> get props => <Object?>[verifier, verifyRequestId, yes];
}
