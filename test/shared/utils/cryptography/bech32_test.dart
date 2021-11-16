import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/bech32.dart';

void main() {
  // @formatter:off
  // Actual Values for tests
  String actualHumanReadablePart = 'kira';
  List<int> actualIntList = <int>[13,41,239,196,115,78,15,223,145,175,184,1,196,71,191,112,61,105,68,97];

  // Expected Values of tests
  String expectedBech32Address = 'kira1p557l3rnfc8alyd0hqqug3alwq7kj3rpg930y0';
  // @formatter:on

  group('Tests of BECH32 algorithm', () {
    test('Should correctly encode given int array via BECH32 algorithm', () async {
      expect(
        Bech32.encode(actualHumanReadablePart, Uint8List.fromList(actualIntList)),
        expectedBech32Address,
      );
    });
  });
}
