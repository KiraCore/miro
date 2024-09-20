import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegations_filter_options.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/menu/my_acount_page/undelegations_page/undelegations_filter_options_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  final ValidatorSimplifiedModel validatorSimplifiedModel1 = ValidatorSimplifiedModel(
    walletAddress: AWalletAddress.fromAddress('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
    moniker: 'GENESIS VALIDATOR',
    website: 'https://www.wp.pl/',
  );

  final ValidatorSimplifiedModel validatorSimplifiedModel2 = ValidatorSimplifiedModel(
    walletAddress: AWalletAddress.fromAddress('kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457'),
    moniker: 'EXODUS VALIDATOR',
    website: 'https://www.wp.pl/',
  );

  final UndelegationModel undelegationModel1 = UndelegationModel(
      id: 1,
      validatorSimplifiedModel: validatorSimplifiedModel1,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(2000),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701181197000));

  final UndelegationModel undelegationModel2 = UndelegationModel(
      id: 2,
      validatorSimplifiedModel: validatorSimplifiedModel2,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(300),
          tokenAliasModel: TokenAliasModel.local('samolean'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701328486000));

  final UndelegationModel undelegationModel3 = UndelegationModel(
      id: 3,
      validatorSimplifiedModel: validatorSimplifiedModel1,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(50000),
          tokenAliasModel: TokenAliasModel.local('lol'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701694545000));

  final List<UndelegationModel> undelegationModelList = <UndelegationModel>[
    undelegationModel1,
    undelegationModel2,
    undelegationModel3,
  ];

  group('Tests of UndelegationsFilterOptions.search()', () {
    test('Should return [List of UndelegationModel] with token "samolean"', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('samolean');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel2,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with token amount of "50000"', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('50000');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel3,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with token "ukex", amount of 2000', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('2000 ukex');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel1,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with address equal "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457"', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('kira1qf');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel2,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with moniker "EXODUS VALIDATOR"', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('EXODUS');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel2,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with expiration date in November (short month form)', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('Nov');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel1,
        undelegationModel2,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] with expiration date in December (long month form)', () {
      // Arrange
      FilterComparator<UndelegationModel> filterComparator = UndelegationsFilterOptions.search('December');

      // Act
      List<UndelegationModel> actualUndelegationModelList = undelegationModelList.where(filterComparator).toList();

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel3,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });
  });
}
