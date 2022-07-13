import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

void main() {
  TokenAliasModel kexTokenAliasModel = TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: const TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: const TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  TokenAliasModel btcTokenAliasModel = TokenAliasModel(
    name: 'Bitcoin',
    lowestTokenDenominationModel: const TokenDenominationModel(name: 'satoshi', decimals: 0),
    defaultTokenDenominationModel: const TokenDenominationModel(name: 'BTC', decimals: 8),
  );

  TokenAliasModel ethTokenAliasModel = TokenAliasModel(
    name: 'Etherum',
    lowestTokenDenominationModel: const TokenDenominationModel(name: 'wei', decimals: 0),
    defaultTokenDenominationModel: const TokenDenominationModel(name: 'ETH', decimals: 18),
  );

  // @formatter:off
  List<BalanceModel> balanceModelsList = <BalanceModel>[
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
    //----------
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
    BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
  ];
  // @formatter:on

  group('Tests of filterBySmallValues', () {
    test('Should return balances bigger than 1 in default denomination', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.filterBySmallValues.filterComparator;

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });

  group('Tests of search method', () {
    test('Should return balances containing "10"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('10');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return balances containing "erum"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('erum');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return balances containing "sato"', () {
      // Arrange
      FilterComparator<BalanceModel> filterComparator = BalancesFilterOptions.search('sato');

      // Act
      List<BalanceModel> actualBalancesList = balanceModelsList.where(filterComparator).toList();

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmountModel: TokenAmountModel(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });
}
