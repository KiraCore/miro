import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_rewards.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class StakingMsgClaimRewardsModel extends ATxMsgModel {
  final AWalletAddress senderWalletAddress;

  const StakingMsgClaimRewardsModel({
    required this.senderWalletAddress,
  }) : super(txMsgType: TxMsgType.msgClaimRewards);

  factory StakingMsgClaimRewardsModel.fromMsgDto(MsgClaimRewards msgClaimRewards) {
    return StakingMsgClaimRewardsModel(
      senderWalletAddress: AWalletAddress.fromAddress(msgClaimRewards.sender),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgClaimRewards(
      sender: senderWalletAddress.address,
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.star_border);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return senderWalletAddress.address;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgClaimRewards;
  }

  @override
  List<Object?> get props => <Object>[senderWalletAddress];
}
