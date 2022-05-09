import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';

void main() {
  group('Tests of CryptoAddressParser.bytesToHex() method', () {
    // @formatter:off
    final Uint8List actualBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
    // @formatter:on
    test('Should return parsed given bytes to the hex address with 0x prefix ', () {
      expect(
        CryptoAddressParser.bytesToHex(actualBytes),
        '0x437832172d98e523a7fc748b9ed33ac72921964c',
      );
    });

    test('Should return parsed given bytes to the hex address with 0x prefix and 50 pad length ', () {
      expect(
        CryptoAddressParser.bytesToHex(actualBytes, forcePadLength: 50),
        '0x0000000000437832172d98e523a7fc748b9ed33ac72921964c',
      );
    });
  });

  group('Tests of CryptoAddressParser.hexToBytes() method', () {
    // @formatter:off
    const String actualHex = '0x437832172d98e523a7fc748b9ed33ac72921964c';
    final Uint8List expectedBytes = Uint8List.fromList(<int>[67, 120, 50, 23, 45, 152, 229, 35, 167, 252, 116, 139, 158, 211, 58, 199, 41, 33, 150, 76]);
    // @formatter:on
    test('Should return bytes from given hex address', () {
      expect(
        CryptoAddressParser.hexToBytes(actualHex),
        expectedBytes,
      );
    });
  });

  group('Tests of CryptoAddressParser.stripHexPrefix() method', () {
    // @formatter:off
    const String actualHex = '0x437832172d98e523a7fc748b9ed33ac72921964c';
    const String expectedHex = '437832172d98e523a7fc748b9ed33ac72921964c';
    // @formatter:on
    test('Should return hex address without 0x prefix ', () {
      expect(
        CryptoAddressParser.stripHexPrefix(actualHex),
        expectedHex,
      );
    });
  });

  group('Tests of CryptoAddressParser.unsignedIntToBytes() method', () {
    // @formatter:off
    final BigInt actualUnsignedInt = BigInt.from(4294967295);
    final Uint8List expectedBytes = Uint8List.fromList(<int>[255, 255, 255, 255]);
    // @formatter:on
    test('Should return bytes from unsigned int', () {
      expect(
        CryptoAddressParser.unsignedIntToBytes(actualUnsignedInt),
        expectedBytes,
      );
    });
  });

  group('Tests of CryptoAddressParser.bytesToUnsignedInt() method', () {
    // @formatter:off
    final Uint8List actualBytes = Uint8List.fromList(<int>[255, 255, 255, 255]);
    final BigInt expectedUnsignedInt = BigInt.from(4294967295);

    // @formatter:on
    test('Should return unsigned int from bytes', () {
      expect(
        CryptoAddressParser.bytesToUnsignedInt(actualBytes),
        expectedUnsignedInt,
      );
    });
  });

  group('Tests of CryptoAddressParser.bytesToInt() method', () {
    // @formatter:off
    final Uint8List actualBytes = Uint8List.fromList(<int>[24, 150, 222, 103, 126, 90, 125, 224, 107, 237, 117, 102, 114, 92, 30, 88, 74, 148, 19, 223, 144, 103, 251, 171, 171, 157, 167, 243, 12, 239, 17, 156]);
    final BigInt expectedInt = BigInt.parse('11122070403585220070824613977251566047543942799146369922011927922925181538716');
    // @formatter:on
    test('Should return BigInt from given bytes', () {
      expect(
        CryptoAddressParser.bytesToInt(actualBytes),
        expectedInt,
      );
    });
  });

  group('Tests of CryptoAddressParser.intToBytes() method', () {
    // @formatter:off
    final BigInt actualInt = BigInt.parse('11122070403585220070824613977251566047543942799146369922011927922925181538716');
    final Uint8List expectedBytes = Uint8List.fromList(<int>[24, 150, 222, 103, 126, 90, 125, 224, 107, 237, 117, 102, 114, 92, 30, 88, 74, 148, 19, 223, 144, 103, 251, 171, 171, 157, 167, 243, 12, 239, 17, 156]);
    // @formatter:on
    test('Should return bytes from given BigInt', () {
      expect(
        CryptoAddressParser.intToBytes(actualInt),
        expectedBytes,
      );
    });
  });
}