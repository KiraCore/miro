import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/utils/transactions/tx_utils_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of TxUtils.buildAmountString() method', () {
    // Arrange
    TokenDenominationModel ukex = const TokenDenominationModel(name: 'ukex', decimals: 0);
    TokenDenominationModel kex = const TokenDenominationModel(name: 'KEX', decimals: 6);

    test('Should return [the same amount] if [amount 0]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('0', kex);

      // Assert
      String expectedAmountString = '0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should return [the same amount] if [amount contains decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5.0', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should return [the same amount] if [TokenDenominationModel indivisible]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5', ukex);

      // Assert
      String expectedAmountString = '5';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [.0 suffix] if [no decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 suffix] if amount [ends with decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5.', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 prefix] if amount [starts with decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('.5', kex);

      // Assert
      String expectedAmountString = '0.5';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 prefix] if amount [equals "."]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('.', kex);

      // Assert
      String expectedAmountString = '0.';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should not change if [amount equals "0."]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('0.', kex);

      // Assert
      String expectedAmountString = '0.';
      expect(actualAmountString, expectedAmountString);
    });
  });

  group('Tests of TxUtils.trimMemoToLength() method', () {
    test('Should return memo without overflowed characters (">>>>>>>>>>>>>>>>" -> ">")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('>>>>>>>>>>>>>>>>', 6);

      // Assert
      String expectedTrimmedMemo = '>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters ("0123456789" -> "01234")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('0123456789', 6);

      // Assert
      String expectedTrimmedMemo = '012345';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters (">0123456789" -> ">")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('>', 6);

      // Assert
      String expectedTrimmedMemo = '>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters ("0123456789>" -> "012345")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('0123456789>', 6);

      // Assert
      String expectedTrimmedMemo = '012345';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });
    test('Should return memo without overflowed characters ("<><>" -> "<>")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('<><>', 12);

      // Assert
      String expectedTrimmedMemo = '<>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });
  });

  group('Tests of TxUtils.replaceMemoRestrictedChars() method', () {
    test('Should return memo with "<", ">" replaced to unicode characters', () {
      // Act
      String actualEncodedMemo = TxUtils.replaceMemoRestrictedChars('Test <memo> with < and >');

      // Assert
      String expectedEncodedMemo = r'Test \u003cmemo\u003e with \u003c and \u003e';
      expect(actualEncodedMemo, expectedEncodedMemo);
    });

    test('Should return unchanged memo for string without "<", ">"', () {
      // Act
      String actualEncodedMemo = TxUtils.replaceMemoRestrictedChars('Memo without restricted characters');

      // Assert
      String expectedEncodedMemo = 'Memo without restricted characters';
      expect(actualEncodedMemo, expectedEncodedMemo);
    });
  });
}
