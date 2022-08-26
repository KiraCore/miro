import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_cubit.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/transactions/token_form/token_form_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  BalanceModel kexBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: actualKexTokenAliasModel,
    ),
  );

  BalanceModel ethBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(5000),
      tokenAliasModel: actualEthTokenAliasModel,
    ),
  );

  group('Tests od TokenFormCubit', () {
    test('Should update TokenFormCubit parameters assigned to specific actions', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        initialBalanceModel: kexBalanceModel,
      );

      // Act
      TokenAmountModel? actualTokenAmountModel = actualTokenFormCubit.tokenAmountModelNotifier.value;

      // Assert
      TokenAmountModel? expectedTokenAmountModel = TokenAmountModel.zero(tokenAliasModel: actualKexTokenAliasModel);

      TestUtils.printInfo('Should return TokenAmountModel with defaultTokenDenomination equal to 0 and KEX TokenAliasModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      TotalBalanceModel? actualTotalBalanceModel = actualTokenFormCubit.totalBalanceModelNotifier.value;

      // Assert
      TotalBalanceModel expectedTotalBalanceModel = TotalBalanceModel(
        balanceModel: kexBalanceModel,
        feeTokenAmountModel: feeTokenAmountModel,
      );

      TestUtils.printInfo('Should return TotalBalanceModel with KEX balanceModel and feeTokenAmountModel');
      expect(actualTotalBalanceModel, expectedTotalBalanceModel);

      // ************************************************************************************************

      // Act
      TokenDenominationModel? actualTokenDenominationModel = actualTokenFormCubit.tokenDenominationModelNotifier.value;

      // Assert
      TokenDenominationModel expectedTokenDenominationModel = actualKexTokenAliasModel.defaultTokenDenominationModel;

      TestUtils.printInfo('Should return defaultTokenDenominationModel from KEX TokenAliasModel');
      expect(actualTokenDenominationModel, expectedTokenDenominationModel);

      // ************************************************************************************************

      // Act
      String actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      String expectedTextAmount = '0';

      TestUtils.printInfo('Should return text amount equal to 0');
      expect(actualTextAmount, expectedTextAmount);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setTokenAmountValue('50', shouldUpdateTextField: true);
      actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      expectedTextAmount = '50';

      TestUtils.printInfo('Should return text amount equal to 50');
      expect(actualTextAmount, expectedTextAmount);

      // ************************************************************************************************

      // Act
      actualTokenAmountModel = actualTokenFormCubit.tokenAmountModelNotifier.value;

      // Assert
      expectedTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(50000000),
        tokenAliasModel: actualKexTokenAliasModel,
      );

      TestUtils.printInfo('Should return TokenAmountModel with lowestDenominationAmount equal to 50000000 and KEX TokenAliasModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setTokenDenominationModel(actualKexTokenAliasModel.lowestTokenDenominationModel);
      actualTokenDenominationModel = actualTokenFormCubit.tokenDenominationModelNotifier.value;

      // Assert
      expectedTokenDenominationModel = actualKexTokenAliasModel.lowestTokenDenominationModel;

      TestUtils.printInfo('Should return lowestTokenDenominationModel from KEX TokenAliasModel');
      expect(actualTokenDenominationModel, expectedTokenDenominationModel);

      // Assert
      TestUtils.printInfo('Should return unchanged TokenAmountModel after changing TokenDenominationModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      expectedTextAmount = '50000000';

      TestUtils.printInfo('Should return text amount equal to 50000000');
      expect(actualTextAmount, expectedTextAmount);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setAllAvailableAmount();
      actualTokenAmountModel = actualTokenFormCubit.tokenAmountModelNotifier.value;

      // Assert
      expectedTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.fromInt(900),
        tokenAliasModel: actualKexTokenAliasModel,
      );

      TestUtils.printInfo('Should return TokenAmountModel with available amount and with KEX TokenAliasModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      expectedTextAmount = '900';

      TestUtils.printInfo('Should return text amount equal to 900');
      expect(actualTextAmount, expectedTextAmount);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setBalanceModel(ethBalanceModel);
      actualTokenAmountModel = actualTokenFormCubit.tokenAmountModelNotifier.value;

      // Assert
      expectedTokenAmountModel = TokenAmountModel.zero(tokenAliasModel: actualEthTokenAliasModel);

      TestUtils.printInfo('Should clear TokenAmountValue after changing BalanceModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      expectedTextAmount = '0';

      TestUtils.printInfo('Should clear TextField after changing BalanceModel');
      expect(actualTextAmount, expectedTextAmount);

      // ************************************************************************************************

      // Act
      actualTokenDenominationModel = actualTokenFormCubit.tokenDenominationModelNotifier.value;

      // Assert
      expectedTokenDenominationModel = actualEthTokenAliasModel.defaultTokenDenominationModel;

      TestUtils.printInfo('Should return defaultTokenDenominationModel from Etherum TokenAliasModel');
      expect(actualTokenDenominationModel, expectedTokenDenominationModel);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setTokenAmountValue('200', shouldUpdateTextField: true);

      // Assert
      expectedTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.parse('200000000000000000000'),
        tokenAliasModel: actualEthTokenAliasModel,
      );

      TestUtils.printInfo('Should return TokenAmountModel with defaultTokenDenomination equal to 200 and Etherum TokenAliasModel');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.clearTokenAmount();
      actualTokenAmountModel = actualTokenFormCubit.tokenAmountModelNotifier.value;

      // Assert
      expectedTokenAmountModel = TokenAmountModel.zero(tokenAliasModel: actualEthTokenAliasModel);

      TestUtils.printInfo('Should clear TokenAmountValue after calling clearTokenAmount()');
      expect(actualTokenAmountModel, expectedTokenAmountModel);

      // ************************************************************************************************

      // Act
      actualTextAmount = actualTokenFormCubit.amountTextEditingController.text;

      // Assert
      expectedTextAmount = '0';

      TestUtils.printInfo('Should clear TextField after calling clearTokenAmount()');
      expect(actualTextAmount, expectedTextAmount);
    });
  });
}
