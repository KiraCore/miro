import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_filter_options.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  WalletAddress walletAddress1 = WalletAddress.fromBech32('kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy');
  WalletAddress walletAddress2 = WalletAddress.fromBech32('kira1gfqq3kqn7tuhnpph4487d57c00dkptt3hefgkk');
  WalletAddress walletAddress3 = WalletAddress.fromBech32('kira13hrpqkv53t82n2e72kfr3kuvvvr3565p234g3g');
  WalletAddress walletAddress4 = WalletAddress.fromBech32('kira1ydv40l75gy83x6lgy3gq08nn5ylxmf2ffs7g97');
  WalletAddress walletAddress5 = WalletAddress.fromBech32('kira154a6j42c8dtafrnpcxhf6rnemkqh3ehvgrvh6n');
  WalletAddress walletAddress6 = WalletAddress.fromBech32('kira14pkvvmxx6g7gay7cxl65zseazs0zjhh2vzuu4g');
  WalletAddress walletAddress7 = WalletAddress.fromBech32('kira19l6sa78vw6sr85ktujy9nps9kq7j3pnmeppkqp');
  WalletAddress walletAddress8 = WalletAddress.fromBech32('kira1zcptq6kkzp7dcu6a5r9hqd84g8xtrdx3mvnv8s');

  WalletAddress valoperWalletAddress1 = WalletAddress.fromBech32('kiravaloper1fffuhtsuc6qskp4tsy5ptjssshynacj4fvag4g');
  WalletAddress valoperWalletAddress2 = WalletAddress.fromBech32('kiravaloper1gfqq3kqn7tuhnpph4487d57c00dkptt3yl4tw6');
  WalletAddress valoperWalletAddress3 = WalletAddress.fromBech32('kiravaloper13hrpqkv53t82n2e72kfr3kuvvvr3565pehftfy');
  WalletAddress valoperWalletAddress4 = WalletAddress.fromBech32('kiravaloper1ydv40l75gy83x6lgy3gq08nn5ylxmf2f6kztaj');
  WalletAddress valoperWalletAddress5 = WalletAddress.fromBech32('kiravaloper154a6j42c8dtafrnpcxhf6rnemkqh3ehvm9s5zl');
  WalletAddress valoperWalletAddress6 = WalletAddress.fromBech32('kiravaloper14pkvvmxx6g7gay7cxl65zseazs0zjhh2lyqldy');
  WalletAddress valoperWalletAddress7 = WalletAddress.fromBech32('kiravaloper19l6sa78vw6sr85ktujy9nps9kq7j3pnm28a4cd');
  WalletAddress valoperWalletAddress8 = WalletAddress.fromBech32('kiravaloper1zcptq6kkzp7dcu6a5r9hqd84g8xtrdx3g200lu');

  List<ValidatorModel> validatorsList = <ValidatorModel>[
    ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valoperWalletAddress: valoperWalletAddress1),
    ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana4', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress2),
    ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut3', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress3),
    ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen2', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress4),
    ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig1', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valoperWalletAddress: valoperWalletAddress5),
    ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape2', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress6),
    ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry3', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress7),
    ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice4', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress8),
  ];

  group('Tests of filterByActiveValidators', () {
    test('Should return only active validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByActiveValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valoperWalletAddress: valoperWalletAddress1),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig1', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valoperWalletAddress: valoperWalletAddress5),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByInactiveValidators', () {
    test('Should return only inactive validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByInactiveValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana4', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress2),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape2', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress6),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByJailedValidators', () {
    test('Should return only jailed validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByJailedValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut3', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress3),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry3', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress7),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByPausedValidators', () {
    test('Should return only paused validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByPausedValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen2', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress4),
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice4', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valoperWalletAddress: valoperWalletAddress8),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of search method', () {
    test('Should return only validators matching "apple"', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.search('apple');

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valoperWalletAddress: valoperWalletAddress1),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return only validators matching "1"', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.search('1');

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valoperWalletAddress: valoperWalletAddress1),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig1', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valoperWalletAddress: valoperWalletAddress5),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });
}
