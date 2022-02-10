import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';

void main() {
  // @formatter:off
  final Uint8List actualPrivateKeyBytes = Uint8List.fromList(<int>[158, 115, 126, 2, 208, 98, 193, 1, 114, 159, 189, 20, 131, 168, 118, 66, 223, 196, 48, 193, 71, 233, 115, 59, 192, 240, 216, 104, 85, 120, 94, 60]);
  final BigInt actualPrivateKeyUnsignedInt = BigInt.parse('71669487184510774183070272777170911733829718364494460937630112170091356905020');
  final Uint8List actualPublicKeyBytes = Uint8List.fromList(<int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124]);

  final Uint8List expectedPublicKeyBytes = Uint8List.fromList(<int>[2, 230, 163, 243, 204, 78, 142, 181, 242, 255, 18, 127, 23, 240, 26, 81, 90, 37, 87, 1, 55, 60, 94, 73, 154, 3, 71, 10, 32, 131, 46, 111, 124]);
  final Uint8List expectedAddress = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
  // @formatter:on

  group('Tests of privateKeyBytesToPublic() method', () {
    test('Should return public key bytes from derived private key bytes', () {
      expect(
        Secp256k1.privateKeyBytesToPublic(actualPrivateKeyBytes),
        expectedPublicKeyBytes,
      );
    });
  });

  group('Tests of privateKeyToPublic() method', () {
    test('Should return public key bytes from derived private key as int', () {
      expect(
        Secp256k1.privateKeyToPublic(actualPrivateKeyUnsignedInt),
        expectedPublicKeyBytes,
      );
    });
  });

  group('Tests of publicKeyToAddress() method', () {
    test('Should return address bytes from derived public key bytes', () {
      expect(
        Secp256k1.publicKeyToAddress(actualPublicKeyBytes),
        expectedAddress,
      );
    });
  });
}
