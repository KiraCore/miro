import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

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

  group('Tests for TokenBalanceModel if balance TokenAliasModel equals fee TokenAliasModel', () {
    // Arrange
    TotalBalanceModel totalBalanceModel = TotalBalanceModel(
      balanceModel: BalanceModel(
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(1000),
          tokenAliasModel: actualKexTokenAliasModel,
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
        tokenAliasModel: actualKexTokenAliasModel,
      );

      expect(actualAvailableTokenAmountModel, expectedAvailableTokenAmountModel);
    });

    test('Should return total balance for KEX', () {
      // Act
      TokenAmountModel actualTotalTokenAmountModel = totalBalanceModel.totalTokenAmountModel;

      // Assert
      TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(1000),
        tokenAliasModel: actualKexTokenAliasModel,
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
          tokenAliasModel: actualEthTokenAliasModel,
        ),
      ),
      feeTokenAmountModel: feeTokenAmountModel,
    );

    TokenAmountModel expectedTotalTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: actualEthTokenAliasModel,
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
