import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

void main() {
  // @formatter:off
  List<BalanceModel> balanceModelsList = <BalanceModel>[
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
  ];
  // @formatter:on

  group('Tests of BalancesFilterOptions.filterBySmallValues()', () {
    test('Should return [List of BalanceModel] with amount greater than 1 in default denomination', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.filterBySmallValues.filterComparator;

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });

  group('Tests of BalancesFilterOptions.search()', () {
    test('Should return [List of BalanceModel] with balances containing "10"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('10');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return [List of BalanceModel] with balances containing "erum"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('erum');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return [List of BalanceModel] with balances containing "sato"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('sato');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: TestUtils.btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });
}
