import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/tx_price_model.dart';
import 'package:miro/test/utils/test_utils.dart';

void main() {
  // Arrange
  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  group('Tests for [TxPriceModel] if [AMOUNT token equals FEE token]', () {
    // Arrange
    TxPriceModel actualTxPriceModel = TxPriceModel(
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    test('Should return [TokenAmountModel] [with added AMOUNT net value and FEE value]', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = actualTxPriceModel.totalTokenAmountModel;

      // Assert
      TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1100),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      expect(actualTotalTokenAmountModel, expectedTotalTokenAmountModel);
    });

    test('Should return [TokenAmountModel] [with AMOUNT net value only]', () {
      // Act
      TokenAmountModel actualNetTokenAmountModel = actualTxPriceModel.netTokenAmountModel;

      // Assert
      TokenAmountModel expectedNetTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      expect(actualNetTokenAmountModel, expectedNetTokenAmountModel);
    });
  });

  group('Tests for [TxPriceModel] if [AMOUNT token different than FEE token]', () {
    // Arrange
    TxPriceModel actualTxPriceModel = TxPriceModel(
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    );

    test('Should return [TokenAmountModel] [with AMOUNT net value only]', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = actualTxPriceModel.totalTokenAmountModel;

      // Assert
      expect(actualTotalTokenAmountModel, expectedTokenAmountModel);
    });

    test('Should return [TokenAmountModel] [with AMOUNT net value only]', () {
      // Act
      TokenAmountModel actualNetTokenAmountModel = actualTxPriceModel.netTokenAmountModel;

      // Assert
      expect(actualNetTokenAmountModel, expectedTokenAmountModel);
    });
  });
}
