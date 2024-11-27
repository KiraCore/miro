part of '../a_tx_msg_model.dart';

class IRMsgCancelVerificationRequestModel extends ATxMsgModel {
  final BigInt verifyRequestId;
  final WalletAddress walletAddress;

  const IRMsgCancelVerificationRequestModel({
    required this.verifyRequestId,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgCancelIdentityRecordsVerifyRequest);

  factory IRMsgCancelVerificationRequestModel.fromDto(MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest) {
    return IRMsgCancelVerificationRequestModel(
      verifyRequestId: msgCancelIdentityRecordsVerifyRequest.verifyRequestId,
      walletAddress: WalletAddress.fromBech32(msgCancelIdentityRecordsVerifyRequest.executor.value),
    );
  }

  @override
  MsgCancelIdentityRecordsVerifyRequest toMsgDto() {
    return MsgCancelIdentityRecordsVerifyRequest(
      executor: CosmosAccAddress(walletAddress.bech32Address),
      verifyRequestId: verifyRequestId,
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.cancel_outlined);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => verifyRequestId.toString();

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgCancelIdentityRecordsVerifyRequest;

  @override
  WalletAddress get fromAddress => walletAddress;

  @override
  List<Object?> get props => <Object>[verifyRequestId, walletAddress];
}
