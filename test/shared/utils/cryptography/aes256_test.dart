import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

void main() {
  // Actual Values for tests
  String actualPassword = 'kiraTest123';
  String actualStringToEncrypt = 'kiratest';
  String actualStringToDecrypt = 'w/zaMaXjbZtgoxsNo+rrDg==';

  // Expected Values of tests
  String expectedEncryptedString = 'w/zaMaXjbZtgoxsNo+rrDg==';
  String expectedDecryptedString = 'kiratest';

  group('Tests of AES256 algorithm', () {
    test('Should correctly encrypt given string via AES256 algorithm', () async {
      expect(
        Aes256.encrypt(actualPassword, actualStringToEncrypt),
        expectedEncryptedString,
      );
    });

    test('Should correctly decrypt given string via AES256 algorithm', () async {
      expect(
        Aes256.decrypt(actualPassword, actualStringToDecrypt),
        expectedDecryptedString,
      );
    });
  });
}
