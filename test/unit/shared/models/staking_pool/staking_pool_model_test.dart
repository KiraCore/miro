import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/staking_pool/staking_pool_model_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of StakingPoolModel.fillTokenAlias()', () {
    test('Should [StakingPoolModel] with filled token aliases in [votingPower] and [tokens]', () {
      // Arrange
      StakingPoolModel actualRawStakingPoolModel = StakingPoolModel(
        slashed: '0%',
        totalDelegators: 1,
        votingPower: <TokenAmountModel>[
          TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ],
        commission: '10%',
        tokens: <TokenAliasModel>[TokenAliasModel.local('ukex')],
      );

      // Act
      StakingPoolModel actualStakingPoolModel = actualRawStakingPoolModel.fillTokenAliases(TestUtils.tokenAliasModelList);

      // Assert
      StakingPoolModel expectedRawStakingPoolModel = StakingPoolModel(
        slashed: '0%',
        totalDelegators: 1,
        votingPower: <TokenAmountModel>[
          TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TestUtils.kexTokenAliasModel,
          ),
        ],
        commission: '10%',
        tokens: <TokenAliasModel>[TestUtils.kexTokenAliasModel],
      );

      expect(actualStakingPoolModel, expectedRawStakingPoolModel);
    });
  });
}
