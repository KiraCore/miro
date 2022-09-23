import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/tokens/tx_price_model.dart';

void main() {
  // Arrange
  TokenAlias kexTokenAlias = const TokenAlias(
    decimals: 6,
    denoms: <String>['ukex', 'mkex'],
    name: 'Kira',
    symbol: 'KEX',
    icon: '',
    amount: '3000000000',
  );

  TokenAliasModel actualKexTokenAliasModel = TokenAliasModel.fromDto(kexTokenAlias);
  TokenAliasModel actualEthTokenAliasModel = const TokenAliasModel(
    name: 'Etherum',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'wei', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'ETH', decimals: 18),
  );

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: actualKexTokenAliasModel,
  );

  group('Tests for TxPriceModel if TokenAliasModel from tokenAmountModel equals fee TokenAliasModel', () {
    // Arrange
    TxPriceModel actualTxPriceModel = TxPriceModel(
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: actualKexTokenAliasModel,
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    test('Should return tokenAmountModel with added value from feeTokenAmountModel', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = actualTxPriceModel.totalTokenAmountModel;

      // Assert
      TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1100),
        tokenAliasModel: actualKexTokenAliasModel,
      );

      expect(actualTotalTokenAmountModel, expectedTotalTokenAmountModel);
    });

    test('Should return tokenAmountModel without value from feeTokenAmountModel', () {
      // Act
      TokenAmountModel actualNetTokenAmountModel = actualTxPriceModel.netTokenAmountModel;

      // Assert
      TokenAmountModel expectedNetTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: actualKexTokenAliasModel,
      );

      expect(actualNetTokenAmountModel, expectedNetTokenAmountModel);
    });
  });

  group('Tests for TxPriceModel if TokenAliasModel from tokenAmountModel is different than fee TokenAliasModel', () {
    // Arrange
    TxPriceModel actualTxPriceModel = TxPriceModel(
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: actualEthTokenAliasModel,
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: actualEthTokenAliasModel,
    );

    test('Should return tokenAmountModel without value from feeTokenAmountModel', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = actualTxPriceModel.totalTokenAmountModel;

      // Assert
      expect(actualTotalTokenAmountModel, expectedTokenAmountModel);
    });

    test('Should return tokenAmountModel without value from feeTokenAmountModel', () {
      // Act
      TokenAmountModel actualNetTokenAmountModel = actualTxPriceModel.netTokenAmountModel;

      // Assert
      expect(actualNetTokenAmountModel, expectedTokenAmountModel);
    });
  });
}
