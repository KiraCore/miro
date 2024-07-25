import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

/// Single identity record info. Used in MsgRegisterIdentityRecords
/// Represents IdentityInfoEntry interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class IdentityInfoEntry extends Equatable with ProtobufMixin {
  /// The key of the identity record
  final String key;

  /// The value of the identity record
  final String info;

  const IdentityInfoEntry({
    required this.key,
    required this.info,
  });

  factory IdentityInfoEntry.fromData(Map<String, dynamic> data) {
    return IdentityInfoEntry(
      key: data['key'] as String,
      info: data['info'] as String,
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, key),
      ...ProtobufEncoder.encode(2, info),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      'key': key,
      'info': info,
    };
  }

  @override
  List<Object?> get props => <Object?>[key, info];
}
