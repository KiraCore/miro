import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Proposal message to approve or reject an identity record request
/// Represents MsgHandleIdentityRecordsVerifyRequest interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgHandleIdentityRecordsVerifyRequest extends ATxMsg {
  /// The address of verifier
  final CosmosAccAddress verifier;

  /// The id of verification request
  final int verifyRequestId;

  /// Defines approval or rejecting an identity request
  final bool yes;

  MsgHandleIdentityRecordsVerifyRequest({
    required this.verifier,
    required this.verifyRequestId,
    required this.yes,
  }) : super(typeUrl: '/kira.gov.MsgHandleIdentityRecordsVerifyRequest');

  factory MsgHandleIdentityRecordsVerifyRequest.fromData(Map<String, dynamic> data) {
    return MsgHandleIdentityRecordsVerifyRequest(
      verifier: CosmosAccAddress(data['verifier'] as String),
      verifyRequestId: data['verify_request_id'] as int,
      yes: data['yes'] as bool? ?? false,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, verifier.bytes),
      ...ProtobufEncoder.encode(2, verifyRequestId),
      if (yes == true) ...ProtobufEncoder.encode(3, yes),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'verifier': verifier.value,
      'verify_request_id': verifyRequestId.toString(),
      if (yes == true) 'yes': yes,
    };
  }

  @override
  List<Object?> get props => <Object?>[verifier, verifyRequestId, yes];
}
