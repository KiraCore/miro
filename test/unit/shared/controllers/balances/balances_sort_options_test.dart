import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/balances_page/balances_sort_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';

void main() {
  TokenAliasModel kexTokenAliasModel = TokenAliasModel(
    name: 'Kira',
    lowestTokenDenomination: const TokenDenomination(name: 'ukex', decimals: 0),
    defaultTokenDenomination: const TokenDenomination(name: 'KEX', decimals: 6),
  );

  TokenAliasModel btcTokenAliasModel = TokenAliasModel(
    name: 'Bitcoin',
    lowestTokenDenomination: const TokenDenomination(name: 'satoshi', decimals: 0),
    defaultTokenDenomination: const TokenDenomination(name: 'BTC', decimals: 8),
  );

  TokenAliasModel ethTokenAliasModel = TokenAliasModel(
    name: 'Etherum',
    lowestTokenDenomination: const TokenDenomination(name: 'wei', decimals: 0),
    defaultTokenDenomination: const TokenDenomination(name: 'ETH', decimals: 18),
  );

  // @formatter:off
  List<BalanceModel> balanceModelsList = <BalanceModel>[
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    //----------
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
    //----------
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
    BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
  ];
  // @formatter:on

  group('Tests of sortByDenom', () {
    test('Should return balanceModelsList sorted by "denom" ascending', () {
      // Act
      List<BalanceModel> actualBalancesList =
          BalancesSortOptions.sortByDenom.sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
        //----------
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
        //----------
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return balanceModelsList sorted by "denom" descending', () {
      // Act
      List<BalanceModel> actualBalancesList =
          BalancesSortOptions.sortByDenom.reversed().sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        //----------
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
        //----------
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });

  group('Tests of sortByAmount', () {
    test('Should return balanceModelsList sorted by "amount" ascending', () {
      // Act
      List<BalanceModel> actualBalancesList =
          BalancesSortOptions.sortByAmount.sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });

    test('Should return balanceModelsList sorted by "denom" descending', () {
      // Act
      List<BalanceModel> actualBalancesList =
          BalancesSortOptions.sortByAmount.reversed().sort(List<BalanceModel>.from(balanceModelsList));

      // Assert
      // @formatter:off
      List<BalanceModel> expectedBalancesList = <BalanceModel>[
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(300000000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(2000000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(200000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: btcTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(100000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: kexTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(1))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(30000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(20000))),
        BalanceModel(tokenAmount: TokenAmount(tokenAliasModel: ethTokenAliasModel, lowestDenominationAmount: Decimal.fromInt(10000))),
      ];
      // @formatter:on

      expect(actualBalancesList, expectedBalancesList);
    });
  });
}