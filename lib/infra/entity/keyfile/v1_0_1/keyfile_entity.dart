import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:hex/hex.dart';
import 'package:miro/infra/entity/keyfile/v1_0_1/keyfile_secret_data_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

class KeyfileEntity extends Equatable {
  final String bech32Address;
  final String secretData;
  final String version;

  const KeyfileEntity({
    required this.bech32Address,
    required this.secretData,
    required this.version,
  });

  factory KeyfileEntity.fromJson(Map<String, dynamic> json) {
    return KeyfileEntity(
      bech32Address: json['bech32Address'] as String,
      secretData: json['secretData'] as String,
      version: json['version'] as String,
    );
  }

  static DecryptedKeyfileModel decrypt(EncryptedKeyfileModel encryptedKeyfileModel, String password) {
    _validate(encryptedKeyfileModel, password);

    KeyfileSecretDataEntity keyfileSecretDataEntity = KeyfileSecretDataEntity.fromEncryptedString(encryptedKeyfileModel.secretDataHash, password);

    return DecryptedKeyfileModel(
      version: encryptedKeyfileModel.version,
      keyfileSecretDataModel: KeyfileSecretDataModel(
        wallet: Wallet(
          address: encryptedKeyfileModel.walletAddress,
          privateKey: Uint8List.fromList(HEX.decode(keyfileSecretDataEntity.privateKey)),
        ),
      ),
    );
  }

  EncryptedKeyfileModel toEncryptedModel() {
    return EncryptedKeyfileModel(
      version: version,
      secretDataHash: secretData,
      walletAddress: WalletAddress.fromBech32(bech32Address),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bech32Address': bech32Address,
      'version': version,
      'secretData': secretData,
    };
  }

  static void _validate(EncryptedKeyfileModel encryptedKeyfileModel, String password) {
    late bool passwordValidBool;
    try {
      passwordValidBool = Aes256.verifyPassword(password, encryptedKeyfileModel.secretDataHash);
    } catch (e) {
      throw const KeyfileException(KeyfileExceptionType.invalidKeyfile);
    }
    if (passwordValidBool == false) {
      throw const KeyfileException(KeyfileExceptionType.wrongPassword);
    }
  }

  @override
  List<Object?> get props => <Object>[bech32Address, version, secretData];
}