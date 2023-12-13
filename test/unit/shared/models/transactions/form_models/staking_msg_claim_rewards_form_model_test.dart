import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_rewards_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_rewards_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  WalletAddress actualSenderWalletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

  group('Tests of StakingMsgClaimRewardsFormModel.canBuildTxMsg()', () {
    test('Should [return TRUE] if [senderWalletAddress] form field is filled', () {
      // Arrange
      StakingMsgClaimRewardsFormModel actualStakingMsgClaimRewardsFormModel = StakingMsgClaimRewardsFormModel(
        senderWalletAddress: actualSenderWalletAddress,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgClaimRewardsFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, true);
    });

    test('Should [return FALSE] if [senderWalletAddress] form field is not filled', () {
      // Arrange
      StakingMsgClaimRewardsFormModel actualStakingMsgClaimRewardsFormModel = StakingMsgClaimRewardsFormModel(
        senderWalletAddress: null,
      );

      // Act
      bool actualBuildAvailableBool = actualStakingMsgClaimRewardsFormModel.canBuildTxMsg();

      // Assert
      expect(actualBuildAvailableBool, false);
    });

    group('Tests of StakingMsgClaimRewardsFormModel.buildTxMsgModel()', () {
      test('Should [return MsgSendModel] if [senderWalletAddress] form field is filled', () {
        // Arrange
        StakingMsgClaimRewardsFormModel actualStakingMsgClaimRewardsFormModel = StakingMsgClaimRewardsFormModel(
          senderWalletAddress: actualSenderWalletAddress,
        );

        // Act
        ATxMsgModel actualMsgSendModel = actualStakingMsgClaimRewardsFormModel.buildTxMsgModel();

        // Assert
        StakingMsgClaimRewardsModel expectedStakingMsgClaimRewardsModel = StakingMsgClaimRewardsModel(
          senderWalletAddress: actualSenderWalletAddress,
        );

        expect(actualMsgSendModel, expectedStakingMsgClaimRewardsModel);
      });

      test('Should [throw Exception] if [senderWalletAddress] form field is not filled', () {
        // Arrange
        StakingMsgClaimRewardsFormModel actualStakingMsgClaimRewardsFormModel = StakingMsgClaimRewardsFormModel(
          senderWalletAddress: null,
        );

        // Assert
        expect(
          () => actualStakingMsgClaimRewardsFormModel.buildTxMsgModel(),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
