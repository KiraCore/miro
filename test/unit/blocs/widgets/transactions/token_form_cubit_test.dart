import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/transactions/token_form_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMockLocator();

  TokenAmountModel feeTokenAmountModel = TokenAmountModel(
    defaultDenominationAmount: Decimal.fromInt(100),
    tokenAliasModel: TestUtils.kexTokenAliasModel,
  );

  BalanceModel kexBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(1000),
      tokenAliasModel: TestUtils.kexTokenAliasModel,
    ),
  );

  BalanceModel ethBalanceModel = BalanceModel(
    tokenAmountModel: TokenAmountModel(
      defaultDenominationAmount: Decimal.fromInt(5000),
      tokenAliasModel: TestUtils.ethTokenAliasModel,
    ),
  );

  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of [TokenFormCubit] initialization', () {
    test('Should return [TokenFormState] with provided values after calling [TokenFormCubit.fromBalance] constructor', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        walletAddress: TestUtils.wallet.address,
      );

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenDenominationModel: kexBalanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: kexBalanceModel.tokenAmountModel.tokenAliasModel),
        walletAddress: TestUtils.wallet.address,
      );

      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');
    });

    test('Should download Balance and return [TokenFormState] after calling [TokenFormCubit.fromTokenAlias]', () async {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit.fromFirstBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        walletAddress: TestUtils.wallet.address,
        initialFilterOption: BalancesFilterOptions.filterByDefaultToken,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenDenominationModel: kexBalanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: kexBalanceModel.tokenAmountModel.tokenAliasModel),
        walletAddress: TestUtils.wallet.address,
      );

      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');
    });
  });

  group('Tests of [TokenFormCubit] process', () {
    test('Should update [TokenFormCubit] parameters assigned to specific actions', () {
      // Arrange
      TokenFormCubit actualTokenFormCubit = TokenFormCubit.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        walletAddress: TestUtils.wallet.address,
        balanceModel: ethBalanceModel,
      );

      // Assert
      TokenFormState expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        walletAddress: TestUtils.wallet.address,
        balanceModel: ethBalanceModel,
      );

      TestUtils.printInfo('Should [return empty TokenFormState] as initial state');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateBalance(kexBalanceModel);

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: TestUtils.kexTokenAliasModel),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated BalanceModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.amountTextEditingController.text = '100';
      actualTokenFormCubit.notifyTokenAmountTextChanged('100');

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateTokenDenomination(TestUtils.kexTokenAliasModel.networkTokenDenominationModel);

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.networkTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated TokenDenominationModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0.0001');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.updateTokenDenomination(TestUtils.kexTokenAliasModel.defaultTokenDenominationModel);

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated TokenDenominationModel');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.setAllAvailableAmount();

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(900),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with all available amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '900');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.clearTokenAmount();

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: TestUtils.kexTokenAliasModel),
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with cleared token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '0');

      // ************************************************************************************************

      // Act
      actualTokenFormCubit.amountTextEditingController.text = '100';
      actualTokenFormCubit.notifyTokenAmountTextChanged('100');

      // Assert
      expectedTokenFormState = TokenFormState.fromBalance(
        feeTokenAmountModel: feeTokenAmountModel,
        balanceModel: kexBalanceModel,
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        tokenDenominationModel: TestUtils.kexTokenAliasModel.defaultTokenDenominationModel,
        walletAddress: TestUtils.wallet.address,
      );

      TestUtils.printInfo('Should [return TokenFormState] with updated token amount');
      expect(actualTokenFormCubit.state, expectedTokenFormState);
      expect(actualTokenFormCubit.amountTextEditingController.text, '100');
    });
  });
}
