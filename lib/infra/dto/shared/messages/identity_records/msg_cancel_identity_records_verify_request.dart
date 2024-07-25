import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Proposal message to edit an identity record
/// Represents MsgCancelIdentityRecordsVerifyRequest interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgCancelIdentityRecordsVerifyRequest extends ATxMsg {
  /// The address of requester
  final CosmosAccAddress executor;

  /// The id of verification request
  final BigInt verifyRequestId;

  MsgCancelIdentityRecordsVerifyRequest({
    required this.executor,
    required this.verifyRequestId,
  }) : super(typeUrl: '/kira.gov.MsgCancelIdentityRecordsVerifyRequest');

  factory MsgCancelIdentityRecordsVerifyRequest.fromData(Map<String, dynamic> data) {
    return MsgCancelIdentityRecordsVerifyRequest(
      executor: CosmosAccAddress(data['executor'] as String),
      verifyRequestId: BigInt.from(data['verify_request_id'] as num),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, executor.bytes),
      ...ProtobufEncoder.encode(2, verifyRequestId),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'executor': executor.value,
      'verify_request_id': verifyRequestId.toString(),
    };
  }

  @override
  List<Object?> get props => <Object?>[executor, verifyRequestId];
}
