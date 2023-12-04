import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_filter_options.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/menu/my_acount_page/staking_page/staking_filter_options_test.dart --platform chrome --null-assertions
void main() {
  final ValidatorSimplifiedModel validatorSimplifiedModel1 = ValidatorSimplifiedModel(
    walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
    moniker: 'GENESIS VALIDATOR',
    website: 'https://www.wp.pl/',
  );

  final ValidatorSimplifiedModel validatorSimplifiedModel2 = ValidatorSimplifiedModel(
    walletAddress: WalletAddress.fromBech32('kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457'),
    moniker: 'EXODUS VALIDATOR',
    website: 'https://www.wp.pl/',
  );

  final ValidatorStakingModel validatorStakingModel1 = ValidatorStakingModel(
    commission: '10%',
    stakingPoolStatus: StakingPoolStatus.enabled,
    tokens: <TokenAliasModel>[
      TokenAliasModel.local('frozen'),
      TokenAliasModel.local('ubtc'),
      TokenAliasModel.local('ukex'),
    ],
    validatorSimplifiedModel: validatorSimplifiedModel1,
  );

  final ValidatorStakingModel validatorStakingModel2 = ValidatorStakingModel(
    commission: '20%',
    stakingPoolStatus: StakingPoolStatus.withdraw,
    tokens: <TokenAliasModel>[
      TokenAliasModel.local('ukex'),
      TokenAliasModel.local('xeth'),
    ],
    validatorSimplifiedModel: validatorSimplifiedModel2,
  );

  final ValidatorStakingModel validatorStakingModel3 = ValidatorStakingModel(
    commission: '30%',
    stakingPoolStatus: StakingPoolStatus.enabled,
    tokens: <TokenAliasModel>[
      TokenAliasModel.local('eth'),
      TokenAliasModel.local('pln'),
      TokenAliasModel.local('usd'),
      TokenAliasModel.local('eur'),
    ],
    validatorSimplifiedModel: validatorSimplifiedModel1,
  );

  final ValidatorStakingModel validatorStakingModel4 = ValidatorStakingModel(
    commission: '40%',
    stakingPoolStatus: StakingPoolStatus.disabled,
    tokens: <TokenAliasModel>[
      TokenAliasModel.local('kek'),
      TokenAliasModel.local('abc'),
      TokenAliasModel.local('def'),
    ],
    validatorSimplifiedModel: validatorSimplifiedModel2,
  );

  final List<ValidatorStakingModel> validatorStakingModelList = <ValidatorStakingModel>[
    validatorStakingModel1,
    validatorStakingModel2,
    validatorStakingModel3,
    validatorStakingModel4,
  ];

  group('Tests of StakingFilterOptions.search()', () {
    test('Should return [List of ValidatorStakingModel] with token "ukex"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('ukex');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[
        validatorStakingModel1,
        validatorStakingModel2,
      ];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return [List of ValidatorStakingModel] with address equal "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('kira1qf');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[
        validatorStakingModel2,
        validatorStakingModel4,
      ];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return [List of ValidatorStakingModel] with moniker "GENESIS VALIDATOR"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('GENESIS');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[
        validatorStakingModel1,
        validatorStakingModel3,
      ];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return [List of ValidatorStakingModel] with website "https://www.wp.pl/"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('wp');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[
        validatorStakingModel1,
        validatorStakingModel2,
        validatorStakingModel3,
        validatorStakingModel4,
      ];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return [List of ValidatorStakingModel] with StakingPoolStatus "Disabled"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('disabled');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[validatorStakingModel4];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return [List of ValidatorStakingModel] with commission equal "30%"', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('30%');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[validatorStakingModel3];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should return empty [List of ValidatorStakingModel] when searching random pattern that does not match any parameter', () {
      // Arrange
      FilterComparator<ValidatorStakingModel> filterComparator = StakingFilterOptions.search('adhgsdffzgx');

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = validatorStakingModelList.where(filterComparator).toList();

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });
  });
}
