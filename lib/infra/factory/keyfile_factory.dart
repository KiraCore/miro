import 'dart:convert';

import 'package:hex/hex.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/entity/keyfile/v1_0_1/export.dart' as v1_0_1;
import 'package:miro/infra/entity/keyfile/v1_1_0/export.dart' as v1_1_0;
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class KeyfileFactory {
  final AppConfig appConfig = globalLocator<AppConfig>();

  EncryptedKeyfileModel buildEncryptedKeyfileFromJson(Map<String, dynamic> keyfileJson) {
    String? version = keyfileJson['version'] as String?;
    if (version == null) {
      throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
    }

    switch (version) {
      case '1.0.0':
      case '1.0.1':
        return v1_0_1.KeyfileEntity.fromJson(keyfileJson).toEncryptedModel();
      case '1.1.0':
        return v1_1_0.KeyfileEntity.fromJson(keyfileJson).toEncryptedModel();
      default:
        throw const KeyfileException(KeyfileExceptionType.unsupportedVersion);
    }
  }

  DecryptedKeyfileModel decryptKeyfileModel(EncryptedKeyfileModel encryptedKeyfileModel, String password) {
    switch (encryptedKeyfileModel.version) {
      case '1.0.0':
      case '1.0.1':
      return v1_0_1.KeyfileEntity.decrypt(encryptedKeyfileModel, password);
      case '1.1.0':
        return v1_1_0.KeyfileEntity.decrypt(encryptedKeyfileModel, password);
      default:
        throw const KeyfileException(KeyfileExceptionType.unsupportedVersion);
    }
  }

  String buildFileContent(DecryptedKeyfileModel keyfileModel, String password) {
    String latestKeyfileVersion = '1.1.0';

    v1_1_0.KeyfileSecretDataEntity keyfileSecretDataEntity = v1_1_0.KeyfileSecretDataEntity(
      privateKey: HEX.encode(keyfileModel.keyfileSecretDataModel.wallet.privateKey),
    );

    v1_1_0.KeyfileEntity keyfileEntity = v1_1_0.KeyfileEntity(
      version: latestKeyfileVersion,
      bech32Address: keyfileModel.keyfileSecretDataModel.wallet.address.bech32Address,
      secretData: Aes256.encrypt(password, jsonEncode(keyfileSecretDataEntity.toJson())),
    );

    Map<String, dynamic> fileContentJson = keyfileEntity.toJson();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String jsonContent = encoder.convert(fileContentJson);

    return jsonContent;
  }
}
