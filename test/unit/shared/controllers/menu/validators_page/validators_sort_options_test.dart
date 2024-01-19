import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_sort_options.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/menu/validators_page/validators_sort_options_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  WalletAddress walletAddress1 = WalletAddress.fromBech32('kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy');
  WalletAddress walletAddress2 = WalletAddress.fromBech32('kira1gfqq3kqn7tuhnpph4487d57c00dkptt3hefgkk');
  WalletAddress walletAddress3 = WalletAddress.fromBech32('kira13hrpqkv53t82n2e72kfr3kuvvvr3565p234g3g');
  WalletAddress walletAddress4 = WalletAddress.fromBech32('kira1ydv40l75gy83x6lgy3gq08nn5ylxmf2ffs7g97');
  WalletAddress walletAddress5 = WalletAddress.fromBech32('kira154a6j42c8dtafrnpcxhf6rnemkqh3ehvgrvh6n');
  WalletAddress walletAddress6 = WalletAddress.fromBech32('kira14pkvvmxx6g7gay7cxl65zseazs0zjhh2vzuu4g');
  WalletAddress walletAddress7 = WalletAddress.fromBech32('kira19l6sa78vw6sr85ktujy9nps9kq7j3pnmeppkqp');
  WalletAddress walletAddress8 = WalletAddress.fromBech32('kira1zcptq6kkzp7dcu6a5r9hqd84g8xtrdx3mvnv8s');

  String valkey1 = 'kiravaloper1fffuhtsuc6qskp4tsy5ptjssshynacj4fvag4g';
  String valkey2 = 'kiravaloper1gfqq3kqn7tuhnpph4487d57c00dkptt3yl4tw6';
  String valkey3 = 'kiravaloper13hrpqkv53t82n2e72kfr3kuvvvr3565pehftfy';
  String valkey4 = 'kiravaloper1ydv40l75gy83x6lgy3gq08nn5ylxmf2f6kztaj';
  String valkey5 = 'kiravaloper154a6j42c8dtafrnpcxhf6rnemkqh3ehvm9s5zl';
  String valkey6 = 'kiravaloper14pkvvmxx6g7gay7cxl65zseazs0zjhh2lyqldy';
  String valkey7 = 'kiravaloper19l6sa78vw6sr85ktujy9nps9kq7j3pnm28a4cd';
  String valkey8 = 'kiravaloper1zcptq6kkzp7dcu6a5r9hqd84g8xtrdx3g200lu';

  List<ValidatorModel> validatorsList = <ValidatorModel>[
    ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
    ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
    ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
    ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
    ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
    ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
    ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
    ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
  ];

  group('Tests of sortByTop', () {
    test('Should return validatorsList sorted by "top" ascending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByTop.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "top" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByTop.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of sortByMoniker', () {
    test('Should return validatorsList sorted by "moniker" ascending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByMoniker.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "moniker" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByMoniker.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of sortByStatus', () {
    test('Should return validatorsList sorted by "status" ascending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByStatus.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "status" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList = ValidatorsSortOptions.sortByStatus.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 4, walletAddress: walletAddress4, moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey4),
        ValidatorModel(top: 8, walletAddress: walletAddress8, moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey8),
        ValidatorModel(top: 3, walletAddress: walletAddress3, moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey3),
        ValidatorModel(top: 7, walletAddress: walletAddress7, moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey7),
        ValidatorModel(top: 2, walletAddress: walletAddress2, moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey2),
        ValidatorModel(top: 6, walletAddress: walletAddress6, moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60', stakingPoolStatus: StakingPoolStatus.disabled, valkey: valkey6),
        ValidatorModel(top: 1, walletAddress: walletAddress1, moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10', stakingPoolStatus: StakingPoolStatus.enabled, valkey: valkey1),
        ValidatorModel(top: 5, walletAddress: walletAddress5, moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50', stakingPoolStatus: StakingPoolStatus.withdraw, valkey: valkey5),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });
}
