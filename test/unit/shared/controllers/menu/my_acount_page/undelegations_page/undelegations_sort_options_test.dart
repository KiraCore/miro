import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegations_sort_options.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  final ValidatorSimplifiedModel validatorSimplifiedModel = ValidatorSimplifiedModel(
    walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
    moniker: 'GENESIS VALIDATOR',
    website: 'https://www.wp.pl/',
  );

  final UndelegationModel undelegationModel1 = UndelegationModel(
      id: 1,
      validatorSimplifiedModel: validatorSimplifiedModel,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(2000),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701181125000));

  final UndelegationModel undelegationModel2 = UndelegationModel(
      id: 2,
      validatorSimplifiedModel: validatorSimplifiedModel,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(300),
          tokenAliasModel: TokenAliasModel.local('samolean'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701181154000));

  final UndelegationModel undelegationModel3 = UndelegationModel(
      id: 3,
      validatorSimplifiedModel: validatorSimplifiedModel,
      tokens: <TokenAmountModel>[
        TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(50000),
          tokenAliasModel: TokenAliasModel.local('lol'),
        ),
      ],
      lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701181197000));

  final List<UndelegationModel> undelegationModelList = <UndelegationModel>[
    undelegationModel1,
    undelegationModel2,
    undelegationModel3,
  ];

  group('Tests of UndelegationsSortOptions.sortByDate', () {
    test('Should return [List of UndelegationModel] [sorted by DATE] ascending', () {
      // Act
      List<UndelegationModel> actualUndelegationModelList = UndelegationsSortOptions.sortByDate.sort(List<UndelegationModel>.from(undelegationModelList));

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel1,
        undelegationModel2,
        undelegationModel3,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });

    test('Should return [List of UndelegationModel] [sorted by DATE] descending', () {
      // Act
      List<UndelegationModel> actualUndelegationModelList =
          UndelegationsSortOptions.sortByDate.reversed().sort(List<UndelegationModel>.from(undelegationModelList));

      // Assert
      List<UndelegationModel> expectedUndelegationModelList = <UndelegationModel>[
        undelegationModel3,
        undelegationModel2,
        undelegationModel1,
      ];

      expect(actualUndelegationModelList, expectedUndelegationModelList);
    });
  });
}
