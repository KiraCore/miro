import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/staking/undelegation_model_test.dart --platform chrome --null-assertions
void main() {
  ValidatorSimplifiedModel actualValidatorSimplifiedModel = ValidatorSimplifiedModel(
    walletAddress: AWalletAddress.fromAddress('kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457'),
    logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    moniker: 'VaMIROdator',
  );

  List<TokenAmountModel> actualTokenAmountModelList = <TokenAmountModel>[
    TokenAmountModel(
      defaultDenominationAmount: Decimal.parse('123'),
      tokenAliasModel: TokenAliasModel.local('ukex'),
    ),
  ];

  DateTime currentTime = DateTime(2023, 12, 14, 10);

  group('Tests of UndelegationModel.isClaimingBlocked', () {
    test('Should [return FALSE] if expiration time is [one hour before currentTime] (14 Dec 2023, 9:00)', () {
      // Arrange
      UndelegationModel actualUndelegationModel = UndelegationModel(
        id: 1,
        lockedUntil: DateTime(2023, 12, 14, 9),
        validatorSimplifiedModel: actualValidatorSimplifiedModel,
        tokens: actualTokenAmountModelList,
      );

      // Act
      bool actualClaimingBlockedBool = actualUndelegationModel.isClaimingBlocked(dateTime: currentTime);

      // Assert
      expect(actualClaimingBlockedBool, false);
    });

    test('Should [return FALSE] if expiration time is [equal currentTime] (14 Dec 2023, 10:00)', () {
      // Arrange
      UndelegationModel actualUndelegationModel = UndelegationModel(
        id: 1,
        lockedUntil: DateTime(2023, 12, 14, 10),
        validatorSimplifiedModel: actualValidatorSimplifiedModel,
        tokens: actualTokenAmountModelList,
      );

      // Act
      bool actualClaimingBlockedBool = actualUndelegationModel.isClaimingBlocked(dateTime: currentTime);

      // Assert
      expect(actualClaimingBlockedBool, false);
    });

    test('Should [return TRUE] if expiration time is [one hour after currentTime] (14 Dec 2023, 11:00)', () {
      // Arrange
      UndelegationModel actualUndelegationModel = UndelegationModel(
        id: 1,
        lockedUntil: DateTime(2123, 12, 14, 11),
        validatorSimplifiedModel: actualValidatorSimplifiedModel,
        tokens: actualTokenAmountModelList,
      );

      // Act
      bool actualClaimingBlockedBool = actualUndelegationModel.isClaimingBlocked(dateTime: currentTime);

      // Assert
      expect(actualClaimingBlockedBool, true);
    });
  });
}
