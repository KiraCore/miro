import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/bech32.dart';

void main() {
  group('Tests of Bech32.encode() method', () {
    // @formatter:off
    // Actual Values for tests
    const String actualHumanReadablePart = 'kira';
    final Uint8List actualIntList = Uint8List.fromList(<int>[13,41,239,196,115,78,15,223,145,175,184,1,196,71,191,112,61,105,68,97]);

    // Expected Values of tests
    const String expectedBech32Address = 'kira1p557l3rnfc8alyd0hqqug3alwq7kj3rpg930y0';
    // @formatter:on

    test('Should return correctly encoded given int array using BECH32 algorithm', () {
      expect(
        Bech32.encode(actualHumanReadablePart, actualIntList),
        expectedBech32Address,
      );
    });
  });

  group('Tests of Bech32.encode() method', () {
    // @formatter:off
    // Actual Values for tests
    const String actualBech32Address = 'kira1p557l3rnfc8alyd0hqqug3alwq7kj3rpg930y0';
    // Expected Values of tests
    const String expectedHumanReadablePart = 'kira';
    final Uint8List expectedIntList = Uint8List.fromList(<int>[13,41,239,196,115,78,15,223,145,175,184,1,196,71,191,112,61,105,68,97]);
    // @formatter:on

    Bech32Pair actualDecodedBech32 = Bech32.decode(actualBech32Address);
    test('Should return correctly decoded int array from bech32 address', () {
      expect(
        actualDecodedBech32.data,
        expectedIntList,
      );
    });

    test('Should return correctly decoded hrp from bech32 address', () {
      expect(
        actualDecodedBech32.hrp,
        expectedHumanReadablePart,
      );
    });
  });
}
