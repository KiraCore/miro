import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Message to delete identity records owned by an address
/// Represents MsgDeleteIdentityRecords interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgDeleteIdentityRecords extends ATxMsg {
  /// The address for the identity record
  final CosmosAccAddress address;

  /// The array string that defines identity record key values to be deleted
  final List<String> keys;

  MsgDeleteIdentityRecords({
    required this.address,
    required this.keys,
  }) : super(typeUrl: '/kira.gov.MsgDeleteIdentityRecords');

  factory MsgDeleteIdentityRecords.fromData(Map<String, dynamic> data) {
    return MsgDeleteIdentityRecords(
      address: CosmosAccAddress(data['address'] as String),
      keys: (data['keys'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, address.bytes),
      ...ProtobufEncoder.encode(2, keys),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address.value,
      'keys': keys,
    };
  }

  @override
  List<Object?> get props => <Object?>[address, keys];
}
