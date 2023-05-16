import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/bip39/bip39_extension.dart';
import 'package:miro/shared/utils/cryptography/bip39/mnemonic_validation_result.dart';

void main() {
  group('Tests of validateMnemonicWithMessage() method', () {
    test('Should return [MnemonicValidationResult.success] if mnemonic is correct', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft effort decrease';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidationResult.success,
      );
    });

    test('Should return [MnemonicValidationResult.invalidChecksum] if mnemonic checksum isn`t correct', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft effort dog';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidationResult.invalidChecksum,
      );
    });

    test('Should return [MnemonicValidationResult.invalidMnemonic] if mnemonic contains custom words', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft jabłko banan';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidationResult.invalidMnemonic,
      );
    });

    test('Should return [MnemonicValidationResult.mnemonicTooShort] if mnemonic is too short', () {
      String actualMnemonic = 'brave pair belt';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidationResult.mnemonicTooShort,
      );
    });
  });
}
