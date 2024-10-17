import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Proposal message to request an identity record verification from a specific verifier
/// Represents MsgRequestIdentityRecordsVerify interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgRequestIdentityRecordsVerify extends ATxMsg {
  /// The address of requester
  final CosmosAccAddress address;

  /// The address of verifier
  final CosmosAccAddress verifier;

  /// The id of records to be verified
  final List<int> recordIds;

  /// The amount of coins to be given up-on accepting the request
  final CosmosCoin tip;

  MsgRequestIdentityRecordsVerify({
    required this.address,
    required this.verifier,
    required this.recordIds,
    required this.tip,
  }) : super(typeUrl: '/kira.gov.MsgRequestIdentityRecordsVerify');

  factory MsgRequestIdentityRecordsVerify.fromData(Map<String, dynamic> data) {
    return MsgRequestIdentityRecordsVerify(
      address: CosmosAccAddress(data['address'] as String),
      verifier: CosmosAccAddress(data['verifier'] as String),
      recordIds: (data['record_ids'] as List<dynamic>).map((dynamic e) => e as int).toList(),
      tip: CosmosCoin.fromProtoJson(data['tip'] as Map<String, dynamic>),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: address,
      2: verifier,
      3: ProtobufBytes(recordIds),
      4: tip,
    });
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address.value,
      'verifier': verifier.value,
      'record_ids': recordIds,
      'tip': tip.toProtoJson(),
    };
  }

  @override
  List<Object?> get props => <Object?>[address, verifier, recordIds, tip];
}
