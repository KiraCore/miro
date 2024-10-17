import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/entity/keyfile/keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/keyfile_secret_data_entity.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class DecryptedKeyfileModel extends Equatable {
  static String latestKeyfileVersion = '2.0.0';
  final KeyfileSecretDataModel keyfileSecretDataModel;
  final String? version;

  const DecryptedKeyfileModel({
    required this.keyfileSecretDataModel,
    this.version,
  });

  String buildFileContent(String password) {
    ECPrivateKey ecPrivateKey = keyfileSecretDataModel.wallet.ecPrivateKey;
    KeyfileSecretDataEntity keyfileSecretDataEntity = KeyfileSecretDataEntity(
      privateKey: HEX.encode(ecPrivateKey.bytes),
    );

    String secretData = Aes256.encrypt(password, jsonEncode(keyfileSecretDataEntity.toJson()));
    KeyfileEntity keyfileEntity = KeyfileEntity(
      version: latestKeyfileVersion,
      publicKey: base64Encode(ecPrivateKey.ecPublicKey.compressed),
      secretData: secretData,
    );

    Map<String, dynamic> fileContentJson = keyfileEntity.toJson();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String jsonContent = encoder.convert(fileContentJson);
    return jsonContent;
  }

  String get fileName {
    Wallet wallet = keyfileSecretDataModel.wallet;
    return 'keyfile_${wallet.address.buildBech32AddressShort(delimiter: '_')}.json';
  }

  @override
  List<Object?> get props => <Object?>[keyfileSecretDataModel, version];
}
