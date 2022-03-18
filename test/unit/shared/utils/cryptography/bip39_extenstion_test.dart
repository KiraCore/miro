import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/bip39_extension.dart';

void main() {
  group('Tests of validateMnemonicWithMessage() method', () {
    test('Should return [MnemonicValidateResult.success] if mnemonic is correct', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft effort decrease';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidateResult.success,
      );
    });

    test('Should return [MnemonicValidateResult.invalidChecksum] if mnemonic checksum isn`t correct', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft effort dog';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidateResult.invalidChecksum,
      );
    });

    test('Should return [MnemonicValidateResult.invalidMnemonic] if mnemonic contains custom words', () {
      String actualMnemonic = 'brave pair belt judge visual tunnel dinner siren dentist craft jabłko banan';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidateResult.invalidMnemonic,
      );
    });

    test('Should return [MnemonicValidateResult.mnemonicTooShort] if mnemonic is too short', () {
      String actualMnemonic = 'brave pair belt';
      expect(
        Bip39Extension.validateMnemonicWithMessage(actualMnemonic),
        MnemonicValidateResult.mnemonicTooShort,
      );
    });
  });
}
