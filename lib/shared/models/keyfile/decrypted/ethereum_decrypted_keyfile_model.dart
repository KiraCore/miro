import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:miro/shared/entity/keyfile/ethereum_keyfile_entity.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:pointycastle/export.dart' hide ECPrivateKey, Mac;

class EthereumDecryptedKeyfileModel extends ADecryptedKeyfileModel {
  const EthereumDecryptedKeyfileModel({
    required super.keyfileSecretDataModel,
  });

  @override
  Future<String> buildFileContent(String password) async {
    ECPrivateKey ecPrivateKey = keyfileSecretDataModel.wallet.ecPrivateKey!;

    List<int> salt = _generateRandomBytes(32);
    List<int> iv = _generateRandomBytes(16);
    List<int> derivedKey = await _deriveKeyFromPassword(password, salt);

    List<int> encryptedPrivateKey = await _encryptPrivateKey(HexCodec.encode(ecPrivateKey.bytes), derivedKey.sublist(0, 16), iv);
    Uint8List mac = _calculateMac(derivedKey.sublist(16), encryptedPrivateKey);

    return jsonEncode(_createKeystore(encryptedPrivateKey, iv, salt, mac).toJson());
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

  Future<List<int>> _encryptPrivateKey(String privateKey, List<int> aesKey, List<int> iv) async {
    AesCtr algorithm = AesCtr.with128bits(macAlgorithm: MacAlgorithm.empty);
    SecretKey secretKey = SecretKey(aesKey);
    List<int> nonce = iv;

    SecretBox encrypted = await algorithm.encrypt(
      HexCodec.decode(privateKey.replaceFirst('0x', '')),
      secretKey: secretKey,
      nonce: nonce,
    );

    return encrypted.cipherText;
  }

  List<int> _generateRandomBytes(int length) {
    Random random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256));
  }

  EthereumKeyfileEntity _createKeystore(List<int> encryptedPrivateKey, List<int> iv, List<int> salt, List<int> mac) {
    return EthereumKeyfileEntity(
      version: 3,
      id: _generateUuid(),
      crypto: EthereumKeyfileCrypto(
        ciphertext: HexCodec.encode(encryptedPrivateKey),
        cipherparams: EthereumKeyfileCipherParams(iv: HexCodec.encode(iv)),
        cipher: 'aes-128-ctr',
        kdf: 'pbkdf2',
        kdfparams: EthereumKeyfileKdfParams(
          dklen: 32,
          salt: HexCodec.encode(salt),
          c: 262144,
          prf: 'hmac-sha256',
        ),
        mac: HexCodec.encode(mac),
      ),
    );
  }

  String _generateUuid() {
    Random random = Random.secure();
    List<int> values = List<int>.generate(16, (int i) => random.nextInt(256));

    values[6] = (values[6] & 0x0f) | 0x40;
    values[8] = (values[8] & 0x3f) | 0x80;

    return '${HexCodec.encode(values.sublist(0, 4))}-${HexCodec.encode(values.sublist(4, 6))}-${HexCodec.encode(values.sublist(6, 8))}-${HexCodec.encode(values.sublist(8, 10))}-${HexCodec.encode(values.sublist(10, 16))}';
  }

  @override
  List<Object?> get props => <Object?>[...super.props];
}
