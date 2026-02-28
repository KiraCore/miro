part of '../a_tx_msg_model.dart';

class StakingMsgClaimUndelegationModel extends ATxMsgModel {
  final WalletAddress senderWalletAddress;
  final String undelegationId;

  const StakingMsgClaimUndelegationModel({
    required this.senderWalletAddress,
    required this.undelegationId,
  }) : super(txMsgType: TxMsgType.msgClaimUndelegation);

  factory StakingMsgClaimUndelegationModel.fromMsgDto(MsgClaimUndelegation msgClaimUndelegation) {
    return StakingMsgClaimUndelegationModel(
      senderWalletAddress: WalletAddress.fromBech32(msgClaimUndelegation.sender),
      undelegationId: msgClaimUndelegation.undelegationId.toString(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgClaimUndelegation(
      sender: senderWalletAddress.bech32Address,
      undelegationId: BigInt.parse(undelegationId),
    );
  }

  @override
  List<Object?> get props => <Object>[senderWalletAddress, undelegationId];

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.compare_arrows);
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
  WalletAddress get fromAddress => senderWalletAddress;

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgClaimUndelegation;
  }
}
