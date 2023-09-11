import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/cryptography/bip39/bip39_extension.dart';
import 'package:miro/shared/utils/cryptography/bip39/mnemonic_validation_result.dart';

void main() {
  group('Tests of [Bip39Extension.findMnemonicWord]', () {
    test('Should return "rabbit" from search pattern "r"', () {
      // Act
      String actualMnemonicWord = Bip39Extension.findMnemonicWord('r');

      // Assert
      String expectedMnemonicWord = 'rabbit';

      expect(actualMnemonicWord, expectedMnemonicWord);
    });

    test('Should return "ready" from search pattern "re"', () {
      // Act
      String actualMnemonicWord = Bip39Extension.findMnemonicWord('re');

      // Assert
      String expectedMnemonicWord = 'ready';

      expect(actualMnemonicWord, expectedMnemonicWord);
    });

    test('Should return "require" from search pattern "req"', () {
      // Act
      String actualMnemonicWord = Bip39Extension.findMnemonicWord('req');

      // Assert
      String expectedMnemonicWord = 'require';

      expect(actualMnemonicWord, expectedMnemonicWord);
    });

    test('Should return empty string if cannot find any matching mnemonic word', () {
      // Act
      String actualMnemonicWord = Bip39Extension.findMnemonicWord('yyyyy');

      // Assert
      String expectedMnemonicWord = '';

      expect(actualMnemonicWord, expectedMnemonicWord);
    });
  });

  group('Tests of [Bip39Extension.isMnemonicWordValid]', () {
    test('Should return true if value is a correct mnemonic word (rabbit)', () {
      // Act
      bool actualMnemonicValid = Bip39Extension.isMnemonicWordValid('rabbit');

      // Assert
      expect(actualMnemonicValid, true);
    });

    test('Should return true if value is a correct mnemonic word (ready)', () {
      // Act
      bool actualMnemonicValid = Bip39Extension.isMnemonicWordValid('ready');

      // Assert
      expect(actualMnemonicValid, true);
    });

    test('Should return false if value is an incorrect mnemonic word (kira)', () {
      // Act
      bool actualMnemonicValid = Bip39Extension.isMnemonicWordValid('kira');

      // Assert
      expect(actualMnemonicValid, false);
    });

    test('Should return false if value is an incorrect mnemonic word (bitcoin)', () {
      // Act
      bool actualMnemonicValid = Bip39Extension.isMnemonicWordValid('bitcoin');

      // Assert
      expect(actualMnemonicValid, false);
    });
  });

  group('Tests of [Bip39Extension.validateMnemonic]', () {
    test('Should return [MnemonicValidationResult.success] if mnemonic is correct', () {
      List<String> actualMnemonicList = <String>[
        'brave',
        'pair',
        'belt',
        'judge',
        'visual',
        'tunnel',
        'dinner',
        'siren',
        'dentist',
        'craft',
        'effort',
        'decrease'
      ];
      expect(
        Bip39Extension.validateMnemonic(mnemonicList: actualMnemonicList, mnemonicSize: 12),
        MnemonicValidationResult.success,
      );
    });

    test('Should return [MnemonicValidationResult.invalidChecksum] if mnemonic checksum isn`t correct', () {
      List<String> actualMnemonicList = <String>['brave', 'pair', 'belt', 'judge', 'visual', 'tunnel', 'dinner', 'siren', 'dentist', 'craft', 'effort', 'dog'];
      expect(
        Bip39Extension.validateMnemonic(mnemonicList: actualMnemonicList, mnemonicSize: 12),
        MnemonicValidationResult.invalidChecksum,
      );
    });

    test('Should return [MnemonicValidationResult.invalidMnemonic] if mnemonic contains custom words', () {
      List<String> actualMnemonicList = <String>['brave', 'pair', 'belt', 'judge', 'visual', 'tunnel', 'dinner', 'siren', 'dentist', 'craft', 'kira', 'core'];
      expect(
        Bip39Extension.validateMnemonic(mnemonicList: actualMnemonicList, mnemonicSize: 12),
        MnemonicValidationResult.invalidMnemonic,
      );
    });

    test('Should return [MnemonicValidationResult.mnemonicTooShort] if mnemonic is too short', () {
      List<String> actualMnemonicList = <String>['brave', 'pair', 'belt'];
      expect(
        Bip39Extension.validateMnemonic(mnemonicList: actualMnemonicList, mnemonicSize: 12),
        MnemonicValidationResult.mnemonicTooShort,
      );
    });
  });
}
