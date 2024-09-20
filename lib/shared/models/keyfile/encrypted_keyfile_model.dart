import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/entity/keyfile/keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/keyfile_secret_data_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class EncryptedKeyfileModel extends Equatable {
  final String version;
  final String encryptedSecretData;
  final Uint8List publicKey;

  const EncryptedKeyfileModel({
    required this.version,
    required this.encryptedSecretData,
    required this.publicKey,
  });

  factory EncryptedKeyfileModel.fromEntity(KeyfileEntity keyfileEntity) {
    return EncryptedKeyfileModel(
      version: keyfileEntity.version,
      encryptedSecretData: keyfileEntity.secretData,
      publicKey: base64Decode(keyfileEntity.publicKey),
    );
  }

  DecryptedKeyfileModel decrypt(String password) {
    bool passwordValidBool = Aes256.verifyPassword(password, encryptedSecretData);
    if (passwordValidBool == false) {
      throw const KeyfileException(KeyfileExceptionType.wrongPassword);
    }

    late KeyfileSecretDataEntity keyfileSecretDataEntity;
    try {
      Map<String, dynamic> secretDataJson = jsonDecode(Aes256.decrypt(password, encryptedSecretData)) as Map<String, dynamic>;
      keyfileSecretDataEntity = KeyfileSecretDataEntity.fromJson(secretDataJson);
    } catch (_) {
      throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
    }

    return DecryptedKeyfileModel(
      version: version,
      keyfileSecretDataModel: KeyfileSecretDataModel(
        wallet: Wallet(
          address: CosmosWalletAddress.fromPublicKey(publicKey),
          ecPrivateKey: ECPrivateKey.fromBytes(HEX.decode(keyfileSecretDataEntity.privateKey), CurvePoints.generatorSecp256k1),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => <Object>[version, encryptedSecretData, publicKey];
}
