import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';

void main() {
  TokenAlias kexTokenAlias = const TokenAlias(
    decimals: 6,
    denoms: <String>['ukex', 'mkex'],
    name: 'Kira',
    symbol: 'KEX',
    icon: '',
    amount: '3000000000',
  );

  TokenAliasModel actualEthTokenAliasModel = TokenAliasModel(
    name: 'Etherum',
    lowestTokenDenomination: const TokenDenomination(name: 'wei', decimals: 0),
    defaultTokenDenomination: const TokenDenomination(name: 'ETH', decimals: 18),
  );
  TokenAliasModel actualSamoleanTokenAliasModel = TokenAliasModel.local('samolean');
  TokenAliasModel actualKexTokenAliasModel = TokenAliasModel.fromTokenAlias(kexTokenAlias);

  group('Tests of TokenAmount', () {
    test('Should return amount in lowest denomination', () {
      // Arrange
      TokenAmount actualTokenAmount = TokenAmount(
        lowestDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: actualEthTokenAliasModel,
      );

      // Act
      String actualLowestDenominationAmount = actualTokenAmount.getAsLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';
      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Arrange
      TokenAmount actualTokenAmount = TokenAmount(
        lowestDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: actualEthTokenAliasModel,
      );

      // Act
      String actualDefaultDenominationAmount = actualTokenAmount.getAsDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '0.0000000000000005';
      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });
  });

  group('Tests of TokenAmount containing TokenAliasModel created from local() constructor', () {
    TokenAmount actualTokenAmount = TokenAmount(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualSamoleanTokenAliasModel,
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmount.getAsLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';
      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination (in this case lowest denomination should be equal default)', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmount.getAsDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';
      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });
  });

  group('Tests of TokenAmount containing TokenAliasModel created from fromTokenAlias() constructor', () {
    TokenAmount actualTokenAmount = TokenAmount(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualKexTokenAliasModel,
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmount.getAsLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';
      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmount.getAsDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '0.0005';
      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });
  });

  group('Tests of TokenAmount working with extra small and extra big values', () {
    test('Should return amount in default denomination', () {
      // Arrange
      TokenAmount actualTokenAmount = TokenAmount(
        lowestDenominationAmount: Decimal.fromInt(4),
        tokenAliasModel: TokenAliasModel(
          name: 'test',
          lowestTokenDenomination: const TokenDenomination(name: 'min', decimals: 0),
          defaultTokenDenomination: const TokenDenomination(name: 'max', decimals: 50),
        ),
      );

      // Act
      String actualDefaultDenominationAmount = actualTokenAmount.getAsDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '0.00000000000000000000000000000000000000000000000004';
      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Arrange
      TokenAmount actualTokenAmount = TokenAmount(
        lowestDenominationAmount: Decimal.parse('400000000000000000000000000000000000000000000000000'),
        tokenAliasModel: TokenAliasModel(
          name: 'test',
          lowestTokenDenomination: const TokenDenomination(name: 'min', decimals: 0),
          defaultTokenDenomination: const TokenDenomination(name: 'max', decimals: 50),
        ),
      );

      // Act
      String actualDefaultDenominationAmount = actualTokenAmount.getAsDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '4';
      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });
  });
}
