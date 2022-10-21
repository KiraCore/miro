import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';

/// MsgHandleIdentityRecordsVerifyRequest defines a proposal
/// message to approve or reject an identity record request
class MsgHandleIdentityRecordsVerifyRequest implements ITxMsg {
  /// The address of verifier
  final String verifier;

  /// The id of verification request
  final BigInt verifyRequestId;

  /// Defines approval or rejecting an identity request
  final bool yes;

  MsgHandleIdentityRecordsVerifyRequest({
    required this.verifier,
    required this.verifyRequestId,
    required this.yes,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': '/kira.gov.MsgHandleIdentityRecordsVerifyRequest',
      'verifier': verifier,
      'verify_request_id': verifyRequestId.toString(),
      'yes': yes,
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': 'kiraHub/MsgHandleIdentityRecordsVerifyRequest',
      'value': <String, dynamic>{
        'verifier': verifier,
        'verify_request_id': verifyRequestId.toString(),
        'yes': yes,
      },
    };
  }
}
