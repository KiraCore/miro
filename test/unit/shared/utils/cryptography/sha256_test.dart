import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';

void main() {
  // Actual Values for tests
  String actualStringToEncrypt = 'kiratest';

  // Expected Values of tests
  String expectedEncryptedString = '51c1657f3cf552b0318bdbd50ac1a2a912f2681deb171fbf4d18e84e84c38750';

  group('Tests of Sha256.encrypt() algorithm', () {
    test('Should correctly encrypt given string via SHA256 algorithm', () async {
      expect(
        Sha256.encrypt(actualStringToEncrypt).toString(),
        expectedEncryptedString,
      );
    });
  });
}
