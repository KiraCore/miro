part of 'a_tx_msg_model.dart';

class MsgSendModel extends ATxMsgModel {
  final WalletAddress fromWalletAddress;
  final WalletAddress toWalletAddress;
  final TokenAmountModel tokenAmountModel;

  const MsgSendModel({
    required this.fromWalletAddress,
    required this.toWalletAddress,
    required this.tokenAmountModel,
  }) : super(txMsgType: TxMsgType.msgSend);

  factory MsgSendModel.fromMsgDto(MsgSend msgSend) {
    return MsgSendModel(
      fromWalletAddress: WalletAddress.fromBech32(msgSend.fromAddress),
      toWalletAddress: WalletAddress.fromBech32(msgSend.toAddress),
      tokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.fromBigInt(msgSend.amount.first.amount),
        tokenAliasModel: TokenAliasModel.local(msgSend.amount.first.denom),
      ),
    );
  }

  @override
  MsgSend toMsgDto() {
    return MsgSend(
      fromAddress: fromWalletAddress.bech32Address,
      toAddress: toWalletAddress.bech32Address,
      amount: <CosmosCoin>[
        CosmosCoin(
          denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInDefaultDenomination().toBigInt(),
        ),
      ],
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return Transform.rotate(
        angle: -pi / 2,
        child: const Icon(AppIcons.arrow_up_right),
      );
    } else {
      return Transform.rotate(
        angle: pi / 2,
        child: const Icon(AppIcons.arrow_up_right),
      );
    }
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[
      PrefixedTokenAmountModel(
        tokenAmountModel: tokenAmountModel,
        tokenAmountPrefixType: txDirectionType == TxDirectionType.outbound ? TokenAmountPrefixType.subtract : TokenAmountPrefixType.add,
      ),
    ];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return toWalletAddress.bech32Address;
    } else {
      return fromWalletAddress.bech32Address;
    }
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    if (txDirectionType == TxDirectionType.outbound) {
      return S.of(context).txMsgSendSendTokens;
    } else {
      return S.of(context).txMsgSendReceiveTokens;
    }
  }

  @override
  WalletAddress get fromAddress => fromWalletAddress;

  @override
  WalletAddress get toAddress => toWalletAddress;

  @override
  List<Object?> get props => <Object>[fromWalletAddress, toWalletAddress, tokenAmountModel];
}
