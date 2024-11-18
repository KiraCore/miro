part of '../a_tx_msg_model.dart';

class StakingMsgClaimRewardsModel extends ATxMsgModel {
  final WalletAddress senderWalletAddress;

  const StakingMsgClaimRewardsModel({
    required this.senderWalletAddress,
  }) : super(txMsgType: TxMsgType.msgClaimRewards);

  factory StakingMsgClaimRewardsModel.fromMsgDto(MsgClaimRewards msgClaimRewards) {
    return StakingMsgClaimRewardsModel(
      senderWalletAddress: WalletAddress.fromBech32(msgClaimRewards.sender),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgClaimRewards(
      sender: senderWalletAddress.bech32Address,
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
    return senderWalletAddress.bech32Address;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgClaimRewards;
  }

  @override
  List<Object?> get props => <Object>[senderWalletAddress];
}
