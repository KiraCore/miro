import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/tokens/token_amount_model_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
void main() {
  group('Tests of TokenAmountModel', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    );

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in network denomination', () {
      // Act
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInNetworkDenomination().toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.0000000000000005';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (network) denomination', () {
      // Act
      TokenDenominationModel networkTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInDenomination(networkTokenDenominationModel).toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.0000000000000005';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel.fromString() constructor', () {
    test('Should return [TokenAmountModel] created from "500ukex" string', () {
      // Act
      TokenAmountModel actualTokenAmountModel = TokenAmountModel.fromString('500ukex');

      // Assert
      TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TokenAliasModel.local('ukex'),
      );

      expect(actualTokenAmountModel, expectedTokenAmountModel);
    });

    test('Should return [TokenAmountModel] created from "500v1/ukex" string', () {
      // Act
      TokenAmountModel actualTokenAmountModel = TokenAmountModel.fromString('500v1/ukex');

      // Assert
      TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TokenAliasModel.local('v1/ukex'),
      );

      expect(actualTokenAmountModel, expectedTokenAmountModel);
    });
  });

  group('Tests of TokenAmountModel containing TokenAliasModel created from local() constructor', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: TokenAliasModel.local('samolean'),
    );

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in network denomination (in this case default denomination should be equal network)', () {
      // Act
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInNetworkDenomination().toString();

      // Assert
      String expectedNetworkDenominationAmount = '500';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (network) denomination (in this case default denomination should be equal network)', () {
      // Act
      TokenDenominationModel networkTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInDenomination(networkTokenDenominationModel).toString();

      // Assert
      String expectedNetworkDenominationAmount = '500';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel containing TokenAliasModel created from fromDto() constructor', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: TestUtils.kexTokenAliasModel,
    );

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in network denomination', () {
      // Act
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInNetworkDenomination().toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.0005';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '500';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (network) denomination', () {
      // Act
      TokenDenominationModel networkTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInDenomination(networkTokenDenominationModel).toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.0005';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel working with very small values', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(4),
      tokenAliasModel: const TokenAliasModel(
        name: 'test',
        defaultTokenDenominationModel: TokenDenominationModel(name: 'min', decimals: 0),
        networkTokenDenominationModel: TokenDenominationModel(name: 'max', decimals: 50),
      ),
    );

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '4';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in network denomination', () {
      // Act
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInNetworkDenomination().toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.00000000000000000000000000000000000000000000000004';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '4';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (network) denomination', () {
      // Act
      TokenDenominationModel networkTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInDenomination(networkTokenDenominationModel).toString();

      // Assert
      String expectedNetworkDenominationAmount = '0.00000000000000000000000000000000000000000000000004';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel working with very big values', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.parse('400000000000000000000000000000000000000000000000000'),
      tokenAliasModel: const TokenAliasModel(
        name: 'test',
        defaultTokenDenominationModel: TokenDenominationModel(name: 'min', decimals: 0),
        networkTokenDenominationModel: TokenDenominationModel(name: 'max', decimals: 50),
      ),
    );

    test('Should return amount in default denomination', () {
      // Act
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '400000000000000000000000000000000000000000000000000';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in network denomination', () {
      // Act
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInNetworkDenomination().toString();

      // Assert
      String expectedNetworkDenominationAmount = '4';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });

    test('Should return amount in selected (default) denomination', () {
      // Act
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDenomination(defaultTokenDenominationModel).toString();

      // Assert
      String expectedDefaultDenominationAmount = '400000000000000000000000000000000000000000000000000';

      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });

    test('Should return amount in selected (network) denomination', () {
      // Act
      TokenDenominationModel networkTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;
      String actualNetworkDenominationAmount = actualTokenAmountModel.getAmountInDenomination(networkTokenDenominationModel).toString();

      // Assert
      String expectedNetworkDenominationAmount = '4';

      expect(actualNetworkDenominationAmount, expectedNetworkDenominationAmount);
    });
  });

  group('Tests of TokenAmountModel.setAmount() method', () {
    // Arrange
    TokenAmountModel actualTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(500),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    );

    test('Should update actualTokenAmount to 1000', () {
      // Act
      actualTokenAmountModel.setAmount(Decimal.fromInt(1000));
      String actualDefaultTokenAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultTokenAmount = '1000';

      expect(actualDefaultTokenAmount, expectedDefaultTokenAmount);
    });

    test('Should update actualTokenAmount to 100000000000000000000000', () {
      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('100000000000000000000000'));
      String actualDefaultTokenAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultTokenAmount = '100000000000000000000000';

      expect(actualDefaultTokenAmount, expectedDefaultTokenAmount);
    });

    test('Should calculate "1000" to default denomination and set it as actual amount', () {
      // Arrange
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;

      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('1000'), tokenDenominationModel: defaultTokenDenominationModel);
      String actualDefaultTokenAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultTokenAmount = '1000000000000000000000';

      expect(actualDefaultTokenAmount, expectedDefaultTokenAmount);
    });

    test('Should calculate "2" to default denomination and set it as actual amount', () {
      // Arrange
      TokenDenominationModel defaultTokenDenominationModel = actualTokenAmountModel.tokenAliasModel.networkTokenDenominationModel;

      // Act
      actualTokenAmountModel.setAmount(Decimal.parse('2'), tokenDenominationModel: defaultTokenDenominationModel);
      String actualDefaultTokenAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultTokenAmount = '2000000000000000000';

      expect(actualDefaultTokenAmount, expectedDefaultTokenAmount);
    });
  });

  group('Tests of TokenAmountModel [ + ] operator overload', () {
    test('Should [add] TokenAmountModels if [aliases EQUAL] ', () {
      // Arrange
      TokenAmountModel actualFirstTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      TokenAmountModel actualSecondTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(600),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      // Act
      TokenAmountModel actualResultTokenAmountModel = actualFirstTokenAmountModel + actualSecondTokenAmountModel;

      // Assert
      TokenAmountModel expectedResultTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(1100),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      expect(actualResultTokenAmountModel, expectedResultTokenAmountModel);
    });

    test('Should [ignore adding] TokenAmountModels if [aliases DIFFERENT] ', () {
      // Arrange
      TokenAmountModel actualFirstTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      TokenAmountModel actualSecondTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(600),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      // Act
      TokenAmountModel actualResultTokenAmountModel = actualFirstTokenAmountModel + actualSecondTokenAmountModel;

      // Assert
      TokenAmountModel expectedResultTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      expect(actualResultTokenAmountModel, expectedResultTokenAmountModel);
    });
  });

  group('Tests of TokenAmountModel [ - ] operator overload', () {
    test('Should [subtract] TokenAmountModels if [aliases EQUAL] ', () {
      // Arrange
      TokenAmountModel actualFirstTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      TokenAmountModel actualSecondTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(400),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      // Act
      TokenAmountModel actualResultTokenAmountModel = actualFirstTokenAmountModel - actualSecondTokenAmountModel;

      // Assert
      TokenAmountModel expectedResultTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(100),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      expect(actualResultTokenAmountModel, expectedResultTokenAmountModel);
    });

    test('Should [ignore subtracting] TokenAmountModels if [aliases DIFFERENT] ', () {
      // Arrange
      TokenAmountModel actualFirstTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      TokenAmountModel actualSecondTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(600),
        tokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      // Act
      TokenAmountModel actualResultTokenAmountModel = actualFirstTokenAmountModel - actualSecondTokenAmountModel;

      // Assert
      TokenAmountModel expectedResultTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      expect(actualResultTokenAmountModel, expectedResultTokenAmountModel);
    });

    test('Should [return 0] if result of subtraction is negative ', () {
      // Arrange
      TokenAmountModel actualFirstTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      TokenAmountModel actualSecondTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(600),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      // Act
      TokenAmountModel actualResultTokenAmountModel = actualFirstTokenAmountModel - actualSecondTokenAmountModel;

      // Assert
      TokenAmountModel expectedResultTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(0),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );

      expect(actualResultTokenAmountModel, expectedResultTokenAmountModel);
    });
  });

  group('Tests of TokenAmount error handling', () {
    test('Should throw ArgumentError for setAmount() method if amount is less than zero', () {
      // Arrange
      TokenAmountModel actualTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.fromInt(500),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
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
        defaultDenominationAmount: Decimal.fromInt(-5000),
        tokenAliasModel: TestUtils.ethTokenAliasModel,
      );
      String actualDefaultDenominationAmount = actualTokenAmountModel.getAmountInDefaultDenomination().toString();

      // Assert
      String expectedDefaultDenominationAmount = '-1';
      expect(actualDefaultDenominationAmount, expectedDefaultDenominationAmount);
    });
  });
}
