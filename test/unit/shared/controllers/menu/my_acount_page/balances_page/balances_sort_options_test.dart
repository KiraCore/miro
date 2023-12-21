import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

void main() {
  List<BalanceModel> balanceModelsList = <BalanceModel>[
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(2000000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(1))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(300000000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(20000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(30000))),
  ];

  group('Tests of BalancesSortOptions.sortByDenom', () {
    test('Should return [List of BalanceModel] [sorted by DENOMINATION] ascending', () {
      // Act
      List<BalanceModel> actualBalancesList = BalancesSortOptions.sortByDenom.sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(300000000))),
        //----------
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(30000))),
        //----------
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
      ];

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return [List of BalanceModel] [sorted by DENOMINATION] descending', () {
      // Act
      List<BalanceModel> actualBalancesList = BalancesSortOptions.sortByDenom.reversed().sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        //----------
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(30000))),
        //----------
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(300000000))),
      ];

      expect(actualBalancesList, expectedBalancesList);
    });
  });

  group('Tests of BalancesSortOptions.sortByAmount', () {
    test('Should return [List of BalanceModel] [sorted by AMOUNT] ascending', () {
      // Act
      List<BalanceModel> actualBalancesList = BalancesSortOptions.sortByAmount.sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(30000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(300000000))),
      ];

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return [List of BalanceModel] [sorted by AMOUNT] descending', () {
      // Act
      List<BalanceModel> actualBalancesList = BalancesSortOptions.sortByAmount.reversed().sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(300000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(30000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, defaultDenominationAmount: Decimal.fromInt(10000))),
      ];

      expect(actualBalancesList, expectedBalancesList);
    });
  });
}
