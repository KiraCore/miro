import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/transactions/token_form_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    lowestDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  BalanceModel kexBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: TestUtils.kexTokenAliasModel,
    ),
  );

  BalanceModel ethBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      lowestDenominationAmount: Decimal.fromInt(5000),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    ),
  );

  group('Tests of [TokenFormCubit] initialization', () {
    test('Should [return empty TokenFormState] if [optional parameters NOT specified]', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit(feeTokenAmountModel: feeTokenAmountModel);

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState(feeTokenAmountModel: feeTokenAmountModel);

      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');
    });

    test('Should return [TokenFormState] with calculated values if [only default BalanceModel specified]', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        defaultBalanceModel: kexBalanceModel,
      );

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenDenominationModel: kexBalanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: kexBalanceModel.tokenAmountModel.tokenAliasModel),
      );

      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');
    });

    test('Should return [TokenFormState] with [specified default values]', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit(
        feeTokenAmountModel: feeTokenAmountModel,
        defaultBalanceModel: kexBalanceModel,
        defaultTokenDenominationModel: TestUtils.kexTokenAliasModel.tokenDenominations[1],
        defaultTokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
      );

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.tokenDenominations[1],
      );

      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');
    });
  });

  group('Tests of [TokenFormCubit] process', () {
    test('Should update [TokenFormCubit] parameters assigned to specific actions', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit(feeTokenAmountModel: feeTokenAmountModel);

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState(feeTokenAmountModel: feeTokenAmountModel);

      TestUtils.printInfo('Should [return empty TokenFormState] as initial state');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateBalance(kexBalanceModel);

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: TestUtils.kexTokenAliasModel),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated BalanceModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.amountTextEditingController.text = '100';
      actualTokenFormCubit.notifyTokenAmountTextChanged('100');

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100000000),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,

      );

      TestUtils.printInfo('Should [return TokenFormState] with updated token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateTokenDenomination(TestUtils.kexTokenAliasModel.lowestTokenDenominationModel);

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100000000),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.lowestTokenDenominationModel,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated TokenDenominationModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100000000');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setAllAvailableAmount();

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(900),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.lowestTokenDenominationModel,
      );

      TestUtils.printInfo('Should [return TokenFormState] with all available amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '900');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.clearTokenAmount();

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenDenominationModel: TestUtils.kexTokenAliasModel.lowestTokenDenominationModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: TestUtils.kexTokenAliasModel),
      );

      TestUtils.printInfo('Should [return TokenFormState] with cleared token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.amountTextEditingController.text = '100';
      actualTokenFormCubit.notifyTokenAmountTextChanged('100');

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.lowestTokenDenominationModel,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateBalance(ethBalanceModel);

      // Assert
      expectedTokenFormState = TokenFormState(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: ethBalanceModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: TestUtils.ethTokenAliasModel),
        tokenDenominationModel: TestUtils.ethTokenAliasModel.defaultTokenDenominationModel,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated BalanceModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');
    });
  });
}
