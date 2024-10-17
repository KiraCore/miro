import 'package:equatable/equatable.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/cosmos_keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/ethereum_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/cosmos_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/ethereum_encrypted_keyfile_model.dart';

abstract class AEncryptedKeyfileModel extends Equatable {
  const AEncryptedKeyfileModel();

  factory AEncryptedKeyfileModel.fromEntity(AKeyfileEntity keyfileEntity) {
    if (keyfileEntity is CosmosKeyfileEntity) {
      return CosmosEncryptedKeyfileModel.fromEntity(keyfileEntity);
    } else if (keyfileEntity is EthereumKeyfileEntity) {
      return EthereumEncryptedKeyfileModel(ethereumKeyfileEntity: keyfileEntity);
    }
    throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
  }

  Future<ADecryptedKeyfileModel> decrypt(String password);

  @override
  List<Object?> get props => <Object>[];
}
