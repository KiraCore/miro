import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class KeyfileSecretDataEntity extends Equatable {
  final String privateKey;

  const KeyfileSecretDataEntity({
    required this.privateKey,
  });

  factory KeyfileSecretDataEntity.fromEncryptedString(String encryptedString, String password) {
    late KeyfileSecretDataEntity secretDataEntity;
    try {
      Map<String, dynamic> secretDataJson = jsonDecode(Aes256.decrypt(password, encryptedString)) as Map<String, dynamic>;
      secretDataEntity = KeyfileSecretDataEntity.fromJson(secretDataJson);
    } catch (_) {
      throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
    }
    return secretDataEntity;
  }

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
