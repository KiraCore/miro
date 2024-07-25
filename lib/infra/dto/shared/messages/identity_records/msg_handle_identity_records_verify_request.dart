import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
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
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: verifier,
      2: ProtobufInt32(verifyRequestId),
      3: ProtobufBool(yes),
    });
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
