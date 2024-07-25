import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';

/// Single identity record info. Used in MsgRegisterIdentityRecords
/// Represents IdentityInfoEntry interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class IdentityInfoEntry extends AProtobufObject {
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
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: ProtobufString(key),
      2: ProtobufString(info),
    });
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
