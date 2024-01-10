import 'package:equatable/equatable.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';

class KeyfileEntity extends Equatable {
  final String version;
  final String publicKey;
  final String secretData;

  const KeyfileEntity({
    required this.version,
    required this.publicKey,
    required this.secretData,
  });

  factory KeyfileEntity.fromJson(Map<String, dynamic> json) {
    try {
      return KeyfileEntity(
        version: json['version'] as String,
        publicKey: json['public_key'] as String,
        secretData: json['secret_data'] as String,
      );
    } catch (_) {
      throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'version': version,
      'public_key': publicKey,
      'secret_data': secretData,
    };
  }

  @override
  List<Object?> get props => <Object>[version, publicKey, secretData];
}
