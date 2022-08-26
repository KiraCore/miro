import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

void main() {
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
  TokenAliasModel actualSamoleanTokenAliasModel = TokenAliasModel.local('samolean');

  group('Tests of TokenAmountModel', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualEthTokenAliasModel,
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '0.0000000000000005';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (lowest) denomination', () {
      // Act
      TokenDenominationModel lowestTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.lowestTokenDenominationModel;
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInDenomination(lowestTokenDenominationModel).toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '0.0000000000000005';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel containing TokenAliasModel created from local() constructor', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualSamoleanTokenAliasModel,
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination (in this case lowest denomination should be equal default)', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (lowest) denomination', () {
      // Act
      TokenDenominationModel lowestTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.lowestTokenDenominationModel;
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInDenomination(lowestTokenDenominationModel).toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (default) denomination (in this case lowest denomination should be equal default)', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel containing TokenAliasModel created from fromDto() constructor', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualKexTokenAliasModel,
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '0.0005';

      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (lowest) denomination', () {
      // Act
      TokenDenominationModel lowestTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.lowestTokenDenominationModel;
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInDenomination(lowestTokenDenominationModel).toString();

      // Assert
      String expectedLowestDenominationAmount = '500';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '0.0005';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel working with very small values', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(4),
      tokenAliasModel: const TokenAliasModel(
        name: 'test',
        lowestTokenDenominationModel: TokenDenominationModel(name: 'min', decimals: 0),
        defaultTokenDenominationModel: TokenDenominationModel(name: 'max', decimals: 50),
      ),
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '4';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '0.00000000000000000000000000000000000000000000000004';

      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (lowest) denomination', () {
      // Act
      TokenDenominationModel lowestTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.lowestTokenDenominationModel;
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInDenomination(lowestTokenDenominationModel).toString();

      // Assert
      String expectedLowestDenominationAmount = '4';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '0.00000000000000000000000000000000000000000000000004';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel working with very big values', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.parse('400000000000000000000000000000000000000000000000000'),
      tokenAliasModel: const TokenAliasModel(
        name: 'test',
        lowestTokenDenominationModel: TokenDenominationModel(name: 'min', decimals: 0),
        defaultTokenDenominationModel: TokenDenominationModel(name: 'max', decimals: 50),
      ),
    );

    test('Should return amount in lowest denomination', () {
      // Act
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '400000000000000000000000000000000000000000000000000';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '4';

      expect(actualDefaultDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (lowest) denomination', () {
      // Act
      TokenDenominationModel lowestTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.lowestTokenDenominationModel;
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInDenomination(lowestTokenDenominationModel).toString();

      // Assert
      String expectedLowestDenominationAmount = '400000000000000000000000000000000000000000000000000';

      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '4';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel.setAmount() method', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: actualEthTokenAliasModel,
    );

    test('Should update actualTokenAmount to 1000', () {
      // Act
      actualTokenAmountModel.setAmount(Decimal.fromInt(1000));
      String actualLowestTokenAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestTokenAmount = '1000';

      expect(actualLowestTokenAmount, expectedLowestTokenAmount);
    });

    test('Should update actualTokenAmount to 100000000000000000000000', () {
      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('100000000000000000000000'));
      String actualLowestTokenAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestTokenAmount = '100000000000000000000000';

      expect(actualLowestTokenAmount, expectedLowestTokenAmount);
    });

    test('Should calculate "1000" to lowest denomination and set it as actual amount', () {
      // Arrange
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;

      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('1000'), tokenDenominationModel: defaultTokenDenominationModel);
      String actualLowestTokenAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestTokenAmount = '1000000000000000000000';

      expect(actualLowestTokenAmount, expectedLowestTokenAmount);
    });

    test('Should calculate "2" to lowest denomination and set it as actual amount', () {
      // Arrange
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;

      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('2'), tokenDenominationModel: defaultTokenDenominationModel);
      String actualLowestTokenAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestTokenAmount = '2000000000000000000';

      expect(actualLowestTokenAmount, expectedLowestTokenAmount);
    });
  });

  group('Tests of TokenAmount error handling', () {
    test('Should throw ArgumentError for setAmount() method if amount is less than zero', () {
      // Arrange
      TokenAmountModel actualTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: actualEthTokenAliasModel,
      );

      // Assert
      expect(
        () => actualTokenAmountModel.setAmount(Decimal.parse('-5')),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Should set -1 as amount if TokenAmountModel constructor has amount less than zero', () {
      // Act
      TokenAmountModel actualTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(-5000),
        tokenAliasModel: actualEthTokenAliasModel,
      );
      String actualLowestDenominationAmount = actualTokenAmountModel.getAmountInLowestDenomination().toString();

      // Assert
      String expectedLowestDenominationAmount = '-1';
      expect(actualLowestDenominationAmount, expectedLowestDenominationAmount);
    });
  });
}
