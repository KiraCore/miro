import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/balances/balance_model_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of BalanceModel.fillTokenAlias()', () {
    test('Should [BalanceModel] with filled token aliases in [tokenAmountModel]', () {
      // Arrange
      BalanceModel actualRawBalanceModel = BalanceModel(
        tokenAmountModel: TokenAmountModel(
          tokenAliasModel: TokenAliasModel.local('ukex'),
          defaultDenominationAmount: Decimal.fromInt(2000),
        ),
      );

      // Act
      BalanceModel actualBalanceModel = actualRawBalanceModel.fillTokenAlias(TestUtils.tokenAliasModelList);

      // Assert
      BalanceModel expectedBalanceModel = BalanceModel(
        tokenAmountModel: TokenAmountModel(
          tokenAliasModel: TestUtils.kexTokenAliasModel,
          defaultDenominationAmount: Decimal.fromInt(2000),
        ),
      );
      expect(actualBalanceModel, expectedBalanceModel);
    });
  });
}
