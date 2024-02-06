import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/delegations/validator_staking_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of ValidatorStakingModel.fillTokenAliases()', () {
    test('Should [ValidatorStakingModel] with filled token aliases in [tokens]', () {
      // Arrange
      ValidatorStakingModel actualRawValidatorStakingModel = ValidatorStakingModel(
        commission: '10%',
        stakingPoolStatus: StakingPoolStatus.enabled,
        tokens: <TokenAliasModel>[
          TokenAliasModel.local('frozen'),
          TokenAliasModel.local('ubtc'),
          TokenAliasModel.local('ukex'),
        ],
        validatorSimplifiedModel: ValidatorSimplifiedModel(
          walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
          moniker: 'GENESIS VALIDATOR',
          logo: 'https://avatars.githubusercontent.com/u/114292385?s=200',
        ),
      );

      // Act
      ValidatorStakingModel actualValidatorStakingModel = actualRawValidatorStakingModel.fillTokenAliases(TestUtils.tokenAliasModelList);

      // Assert
      ValidatorStakingModel expectedValidatorStakingModel = ValidatorStakingModel(
        commission: '10%',
        stakingPoolStatus: StakingPoolStatus.enabled,
        tokens: <TokenAliasModel>[
          TokenAliasModel.local('frozen'),
          TokenAliasModel.local('ubtc'),
          TokenAliasModel.local('ukex'),
        ],
        validatorSimplifiedModel: ValidatorSimplifiedModel(
          walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
          moniker: 'GENESIS VALIDATOR',
          logo: 'https://avatars.githubusercontent.com/u/114292385?s=200',
        ),
      );

      expect(actualValidatorStakingModel, expectedValidatorStakingModel);
    });
  });
}
