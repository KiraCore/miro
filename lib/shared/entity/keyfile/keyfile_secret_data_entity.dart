import 'package:equatable/equatable.dart';

class KeyfileSecretDataEntity extends Equatable {
  final String privateKey;

  const KeyfileSecretDataEntity({
    required this.privateKey,
  });

  factory KeyfileSecretDataEntity.fromJson(Map<String, dynamic> json) {
    return KeyfileSecretDataEntity(
      privateKey: json['private_key'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'private_key': privateKey,
    };
  }

  @override
  List<Object?> get props => <Object>[privateKey];
}
