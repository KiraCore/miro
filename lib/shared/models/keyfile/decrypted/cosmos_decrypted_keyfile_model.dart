import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/entity/keyfile/cosmos_keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/keyfile_secret_data_entity.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class CosmosDecryptedKeyfileModel extends ADecryptedKeyfileModel {
  static String latestKeyfileVersion = '2.0.0';
  final String? version;

  const CosmosDecryptedKeyfileModel({
    required super.keyfileSecretDataModel,
    this.version,
  });

  @override
  Future<String> buildFileContent(String password) async {
    ECPrivateKey ecPrivateKey = keyfileSecretDataModel.wallet.ecPrivateKey!;
    KeyfileSecretDataEntity keyfileSecretDataEntity = KeyfileSecretDataEntity(
      privateKey: HEX.encode(ecPrivateKey.bytes),
    );

    String secretData = Aes256.encrypt(password, jsonEncode(keyfileSecretDataEntity.toJson()));
    CosmosKeyfileEntity keyfileEntity = CosmosKeyfileEntity(
      version: latestKeyfileVersion,
      publicKey: base64Encode(ecPrivateKey.ecPublicKey.compressed),
      secretData: secretData,
    );

    Map<String, dynamic> fileContentJson = keyfileEntity.toJson();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String jsonContent = encoder.convert(fileContentJson);
    return jsonContent;
  }

  @override
  List<Object?> get props => <Object?>[...super.props, version];
}
