import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/aes256.dart';

void main() {
  // Actual Values for tests
  String actualPassword = 'kiraTest123';
  String actualStringToEncrypt = 'kiratest';
  String actualStringToDecrypt = 'wEQo23Uy93RU8EMf1tip5iKnq1VOdUO03cDu3X/l92xEcRLx';

  // Expected Values of tests
  String expectedDecryptedString = 'kiratest';

  group('Tests of Aes256.encrypt() algorithm', () {
    // Output is always random String because method HAS changing initialization vector using Random Secure
    // and we cannot match the hardcoded expected result.
    // That`s why we check whether it is possible to encode and decode text
    test('Should correctly encrypt given string via AES256 algorithm and check with decrypt method', () async {
      final String encryptedData = Aes256.encrypt(actualPassword, actualStringToEncrypt);
      expect(
        Aes256.decrypt(actualPassword, encryptedData),
        expectedDecryptedString,
      );
    });
  });

  group('Tests of Aes256.decrypt() algorithm', () {
    test('Should correctly decrypt given string via AES256 algorithm', () async {
      expect(
        Aes256.decrypt(actualPassword, actualStringToDecrypt),
        expectedDecryptedString,
      );
    });
  });

  group('Tests of Aes256.verifyPassword() algorithm', () {
    test('Should return true if the password is correct', () async {
      expect(
        Aes256.verifyPassword(actualPassword, actualStringToDecrypt),
        true,
      );
    });

    test('Should return false if the password isn`t correct', () async {
      expect(
        Aes256.verifyPassword('incorrect password', actualStringToDecrypt),
        false,
      );
    });
  });
}
