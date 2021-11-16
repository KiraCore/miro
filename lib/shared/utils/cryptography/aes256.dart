import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';

class Aes256 {
  static String encrypt(String password, String content) {
    final Key key = Key(Uint8List.fromList(Sha256.encrypt(password).bytes));
    final Encrypter crypt = Encrypter(AES(key));
    String encryptedString = crypt.encrypt(content, iv: IV.fromLength(16)).base64;
    return encryptedString;
  }

  static String decrypt(String password, String content) {
    final Key key = Key(Uint8List.fromList(Sha256.encrypt(password).bytes));
    final Encrypter crypt = Encrypter(AES(key));
    String decryptedString = crypt.decrypt(Encrypted.fromBase64(content), iv: IV.fromLength(16));
    return decryptedString;
  }
}
