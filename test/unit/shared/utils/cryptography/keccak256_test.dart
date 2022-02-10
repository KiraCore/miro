import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/keccak256.dart';

void main() {
  // @formatter:off
  // Actual values for tests
  const String actualAddressHex = '437832172d98e523a7fc748b9ed33ac72921964c';
  final Uint8List actualAddressBytes = Uint8List.fromList(<int>[52, 51, 55, 56, 51, 50, 49, 55, 50, 100, 57, 56, 101, 53, 50, 51, 97, 55, 102, 99, 55, 52, 56, 98, 57, 101, 100, 51, 51, 97, 99, 55, 50, 57, 50, 49, 57, 54, 52, 99]);

  // Expected values for tests
  final List<int> expectedKeccakAddress = <int>[34, 22, 45, 30, 234, 99, 45, 164, 61, 72, 65, 224, 189, 232, 150, 11, 115, 201, 150, 66, 25, 54, 104, 38, 19, 246, 6, 170, 6, 246, 131, 165];
  // @formatter:on

  group('Tests of Keccak256.encode() method', () {
    test('Should return correctly encoded given int array using keccak256 algorithm', () {
      expect(
        Keccak256.encode(actualAddressBytes),
        expectedKeccakAddress,
      );
    });
  });

  group('Tests of Keccak256.encodeAscii() method', () {
    test('Should return correctly encoded given hex int array using keccak256 algorithm', () {
      expect(
        Keccak256.encodeAscii(actualAddressHex),
        expectedKeccakAddress,
      );
    });
  });
}
