import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/tokens/prefixed_token_amount_model_test.dart --platform chrome --null-assertions
void main() {
  TokenAmountModel actualTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(1000),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  group('Tests of PrefixedTokenAmountModel.getAmountAsString()', () {
    test('Should return [amount in default denomination] with ["+" prefix]', () {
      // Arrange
      PrefixedTokenAmountModel prefixedTokenAmountModel = PrefixedTokenAmountModel(
        tokenAmountModel: actualTokenAmountModel,
        tokenAmountPrefixType: TokenAmountPrefixType.add,
      );

      // Act
      String actualAmountAsString = prefixedTokenAmountModel.getAmountAsString();

      // Assert
      String expectedAmountAsString = '+1000';

      expect(actualAmountAsString, expectedAmountAsString);
    });

    test('Should return [amount in default denomination] with ["-" prefix]', () {
      // Arrange
      PrefixedTokenAmountModel prefixedTokenAmountModel = PrefixedTokenAmountModel(
        tokenAmountModel: actualTokenAmountModel,
        tokenAmountPrefixType: TokenAmountPrefixType.subtract,
      );

      // Act
      String actualAmountAsString = prefixedTokenAmountModel.getAmountAsString();

      // Assert
      String expectedAmountAsString = '-1000';

      expect(actualAmountAsString, expectedAmountAsString);
    });
  });

  group('Tests of PrefixedTokenAmountModel.getDenominationName()', () {
    test('Should return [denomination name] from used TokenAmountModel', () {
      // Arrange
      PrefixedTokenAmountModel prefixedTokenAmountModel = PrefixedTokenAmountModel(
        tokenAmountModel: actualTokenAmountModel,
        tokenAmountPrefixType: TokenAmountPrefixType.add,
      );

      // Act
      String actualDenominationName = prefixedTokenAmountModel.getDenominationName();

      // Assert
      String expectedDenominationName = 'ukex';

      expect(actualDenominationName, expectedDenominationName);
    });
  });

  group('Tests of PrefixedTokenAmountModel.getPrefix()', () {
    test('Should return ["+"]', () {
      // Arrange
      PrefixedTokenAmountModel prefixedTokenAmountModel = PrefixedTokenAmountModel(
        tokenAmountModel: actualTokenAmountModel,
        tokenAmountPrefixType: TokenAmountPrefixType.add,
      );

      // Act
      String actualPrefix = prefixedTokenAmountModel.getPrefix();

      // Assert
      String expectedPrefix = '+';

      expect(actualPrefix, expectedPrefix);
    });

    test('Should return ["-"]', () {
      // Arrange
      PrefixedTokenAmountModel prefixedTokenAmountModel = PrefixedTokenAmountModel(
        tokenAmountModel: actualTokenAmountModel,
        tokenAmountPrefixType: TokenAmountPrefixType.subtract,
      );

      // Act
      String actualPrefix = prefixedTokenAmountModel.getPrefix();

      // Assert
      String expectedPrefix = '-';

      expect(actualPrefix, expectedPrefix);
    });
  });
}
