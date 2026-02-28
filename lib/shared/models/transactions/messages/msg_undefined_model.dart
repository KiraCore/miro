part of 'a_tx_msg_model.dart';

class MsgUndefinedModel extends ATxMsgModel {
  @override
  final WalletAddress? fromAddress;
  @override
  final WalletAddress? toAddress;

  const MsgUndefinedModel({
    required this.fromAddress,
    required this.toAddress,
  }) : super(txMsgType: TxMsgType.undefined);

  factory MsgUndefinedModel.fromMsgDto(MsgUndefined msgDto) {
    return MsgUndefinedModel(
      fromAddress: msgDto.fromAddress != null ? WalletAddress.fromBech32(msgDto.fromAddress!) : null,
      toAddress: msgDto.toAddress != null ? WalletAddress.fromBech32(msgDto.toAddress!) : null,
    );
  }

  @override
  MsgUndefined toMsgDto() {
    return MsgUndefined(
      fromAddress: fromAddress?.bech32Address,
      toAddress: toAddress?.bech32Address,
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.error);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return null;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgUndefined;
  }

  @override
  List<Object?> get props => <Object?>[fromAddress, toAddress];
}
