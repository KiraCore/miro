import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

void main() {
  // Arrange
  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  group('Tests for TokenBalanceModel if balance TokenAliasModel equals fee TokenAliasModel', () {
    // Arrange
    TotalBalanceModel totalBalanceModel = TotalBalanceModel(
      balanceModel: BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(1000),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    test('Should return total balance for KEX token minus fee, if balance TokenAliasModel is equal fee TokenAliasModel', () {
      // Act
      TokenAmountModel actualAvailableTokenAmountModel = totalBalanceModel.availableTokenAmountModel;

      // Assert
      TokenAmountModel expectedAvailableTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(900),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      expect(actualAvailableTokenAmountModel, expectedAvailableTokenAmountModel);
    });

    test('Should return total balance for KEX', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = totalBalanceModel.totalTokenAmountModel;

      // Assert
      TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      expect(actualTotalTokenAmountModel, expectedTotalTokenAmountModel);
    });
  });

  group('Tests for TokenBalanceModel if balance TokenAliasModel is different than fee TokenAliasModel', () {
    // Arrange
    TotalBalanceModel totalBalanceModel = TotalBalanceModel(
      balanceModel: BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(1000),
          tokenAliasModel: TestUtils.ethTokenAliasModel,
        ),
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    );

    test('Should return total balance for ETH token', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = totalBalanceModel.totalTokenAmountModel;

      // Assert
      expect(actualTotalTokenAmountModel, expectedTotalTokenAmountModel);
    });

    test('Should return available balance equals total balance if balance TokenAliasModel is different than fee TokenAliasModel', () {
      // Act
      TokenAmountModel actualAvailableTokenAmountModel = totalBalanceModel.availableTokenAmountModel;

      // Assert
      expect(actualAvailableTokenAmountModel, expectedTotalTokenAmountModel);
    });
  });
}
