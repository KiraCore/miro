import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_undelegation_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_undelegation_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  WalletAddress actualSenderWalletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

  group('Tests of StakingMsgClaimUndelegationFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if required form field is filled', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel = StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: actualSenderWalletAddress,
        undelegationId: '1',
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgClaimUndelegationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if required form field is not filled (senderWalletAddress)', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel =
          StakingMsgClaimUndelegationFormModel(senderWalletAddress: null, undelegationId: '1');

      // Act
      bool actualBuildAvailableBool = actualStakingMsgClaimUndelegationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    test('Should [return FALSE] if required form field is not filled (undelegationId)', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel = StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: actualSenderWalletAddress,
        undelegationId: null,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgClaimUndelegationFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });
  });

  group('Tests of StakingMsgClaimUndelegationFormModel.buildTxMsgModel()', () {
    test('Should [return MsgSendModel] if required form field is filled', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel = StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: actualSenderWalletAddress,
        undelegationId: '1',
      );

      // Act
      ATxMsgModel actualMsgSendModel = actualStakingMsgClaimUndelegationFormModel.buildTxMsgModel();

      // Assert
      StakingMsgClaimUndelegationModel expectedStakingMsgClaimUndelegationModel = StakingMsgClaimUndelegationModel(
        senderWalletAddress: actualSenderWalletAddress,
        undelegationId: '1',
      );

      expect(actualMsgSendModel, expectedStakingMsgClaimUndelegationModel);
    });

    test('Should [throw Exception] if required form field is not filled (undelegationId)', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel = StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: null,
        undelegationId: '1',
      );

      // Assert
      expect(
        () => actualStakingMsgClaimUndelegationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });

    test('Should [throw Exception] if required form field is not filled (senderWalletAddress)', () {
      // Arrange
      StakingMsgClaimUndelegationFormModel actualStakingMsgClaimUndelegationFormModel = StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: actualSenderWalletAddress,
        undelegationId: null,
      );

      // Assert
      expect(
        () => actualStakingMsgClaimUndelegationFormModel.buildTxMsgModel(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
