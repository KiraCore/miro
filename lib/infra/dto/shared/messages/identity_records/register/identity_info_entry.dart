import 'package:equatable/equatable.dart';

/// Single identity record info. Used in MsgRegisterIdentityRecords
/// Represents IdentityInfoEntry interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class IdentityInfoEntry extends Equatable {
  /// The key of the identity record
  final String key;

  /// The value of the identity record
  final String info;

  const IdentityInfoEntry({
    required this.key,
    required this.info,
  });

  factory IdentityInfoEntry.fromJson(Map<String, dynamic> json) {
    return IdentityInfoEntry(
      key: json['key'] as String,
      info: json['info'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': key,
      'info': info,
    };
  }

  @override
  List<Object?> get props => <Object?>[key, info];
}
