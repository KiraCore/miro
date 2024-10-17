import 'dart:convert';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:miro/shared/entity/keyfile/ethereum_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/ethereum_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:pointycastle/export.dart' hide ECPrivateKey, Mac;

class EthereumEncryptedKeyfileModel extends AEncryptedKeyfileModel {
  // NOTE: entity is unpacked because there are lots of internal fields
  final EthereumKeyfileEntity ethereumKeyfileEntity;

  const EthereumEncryptedKeyfileModel({
    required this.ethereumKeyfileEntity,
  });

  @override
  Future<EthereumDecryptedKeyfileModel> decrypt(String password) async {
    List<int> derivedKey = await _deriveKeyFromPassword(
      password,
      HexCodec.decode(ethereumKeyfileEntity.crypto.kdfparams.salt),
      ethereumKeyfileEntity.crypto.kdfparams.c,
    );
    Uint8List mac = HexCodec.decode(ethereumKeyfileEntity.crypto.mac);
    Uint8List derivedMac = _calculateMac(
      derivedKey.sublist(16),
      HexCodec.decode(ethereumKeyfileEntity.crypto.ciphertext),
    );

    if (!listEquals(mac, derivedMac)) {
      throw const KeyfileException(KeyfileExceptionType.wrongPassword);
    }

    List<int> decryptedPrivateKey = await _decryptPrivateKey(
      HexCodec.decode(ethereumKeyfileEntity.crypto.ciphertext),
      derivedKey.sublist(0, 16),
      HexCodec.decode(ethereumKeyfileEntity.crypto.cipherparams.iv),
    );
    return EthereumDecryptedKeyfileModel(
      keyfileSecretDataModel: KeyfileSecretDataModel(
        wallet: Wallet.fromEthereumPrivateKey(HexCodec.encode(decryptedPrivateKey)),
      ),
    );
  }

  Uint8List _calculateMac(List<int> derivedMacKey, List<int> ciphertext) {
    Uint8List input = Uint8List.fromList(derivedMacKey + ciphertext); // Concatenate MAC key + ciphertext

    SHA3Digest sha3 = SHA3Digest(256);
    Uint8List mac = Uint8List(32);
    sha3
      ..update(input, 0, input.length)
      ..doFinal(mac, 0);

    return mac;
  }

  Future<List<int>> _deriveKeyFromPassword(String password, List<int> salt, [int iterations = 262144]) async {
    Pbkdf2 pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: 256,
    );
    SecretKey secretKey = SecretKey(utf8.encode(password));
    SecretKey newSecretKey = await pbkdf2.deriveKey(secretKey: secretKey, nonce: salt);
    return newSecretKey.extractBytes();
  }

  Future<List<int>> _decryptPrivateKey(List<int> ciphertext, List<int> aesKey, List<int> iv) async {
    AesCtr algorithm = AesCtr.with128bits(macAlgorithm: MacAlgorithm.empty);
    SecretKey secretKey = SecretKey(aesKey);
    List<int> nonce = iv;

    List<int> decrypted = await algorithm.decrypt(
      SecretBox(ciphertext, nonce: nonce, mac: Mac.empty),
      secretKey: secretKey,
    );

    return decrypted;
  }

  @override
  List<Object?> get props => <Object?>[...super.props];
}
