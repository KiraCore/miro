import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/exceptions/invalid_mnemonic_exception.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';

void main() {
  // @formatter:off
  // Actual Values for tests
  String actualMnemonic = 'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  String actualInvalidMnemonic = 'this is an invalid mnemonic';

  // Expected Values of tests
  List<int> mnemonicSeed = <int>[114, 228, 102, 104, 248, 35, 254, 120, 42, 171, 177, 56, 53, 130, 116, 125, 99, 81, 244, 100, 43, 4, 51, 199, 60, 111, 108, 251, 170, 124, 14, 95, 162, 11, 110, 6, 170, 218, 237, 5, 212, 78, 104, 118, 226, 93, 168, 47, 228, 46, 121, 70, 244, 65, 130, 14, 219, 29, 92, 223, 60, 105, 217, 163];
  // @formatter:on
  group('Tests of constructor Mnemonic()', () {
    test('Should create Mnemonic class from derived mnemonic and Mnemonic.seed should match the expected value',
        () async {
      expect(
        Mnemonic(value: actualMnemonic).seed,
        mnemonicSeed,
      );
    });
    test('Should throw InvalidMnemonicException because given mnemonic is invalid ', () async {
      expect(
        () => Mnemonic(value: actualInvalidMnemonic),
        throwsA(isA<InvalidMnemonicException>()),
      );
    });
  });
}
