import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';

/// MsgHandleIdentityRecordsVerifyRequest defines a proposal
/// message to approve or reject an identity record request
class MsgHandleIdentityRecordsVerifyRequest extends TxMsg {
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
      // TODO(dominik): That json param, probably will be changed to verify_request_id in future
      'verifyRequestId': verifyRequestId.toString(),
      'yes': yes,
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': 'kiraHub/MsgHandleIdentityRecordsVerifyRequest',
      'value': <String, dynamic>{
        'verifier': verifier,
        // TODO(dominik): That json param, probably will be changed to verify_request_id in future
        'verifyRequestId': verifyRequestId.toString(),
        'yes': yes,
      },
    };
  }
}
