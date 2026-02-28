part of '../a_tx_msg_model.dart';

class StakingMsgDelegateModel extends ATxMsgModel {
  final String valkey;
  final WalletAddress delegatorWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgDelegateModel({
    required this.valkey,
    required this.delegatorWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgDelegate);

  StakingMsgDelegateModel.single({
    required this.valkey,
    required this.delegatorWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgDelegate);

  factory StakingMsgDelegateModel.fromMsgDto(MsgDelegate msgDelegate) {
    return StakingMsgDelegateModel(
      valkey: msgDelegate.valoperAddress,
      delegatorWalletAddress: WalletAddress.fromBech32(msgDelegate.delegatorAddress),
      tokenAmountModels: msgDelegate.amounts
          .map((CosmosCoin coin) => TokenAmountModel(
                defaultDenominationAmount: Decimal.fromBigInt(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgDelegate(
      delegatorAddress: delegatorWalletAddress.bech32Address,
      valoperAddress: valkey,
      amounts: tokenAmountModels.map((TokenAmountModel tokenAmountModel) {
        return CosmosCoin(
          denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInDefaultDenomination().toBigInt(),
        );
      }).toList(),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.attach_money);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return tokenAmountModels
        .map((TokenAmountModel e) => PrefixedTokenAmountModel(tokenAmountModel: e, tokenAmountPrefixType: TokenAmountPrefixType.subtract))
        .toList();
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return valkey;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgDelegate;
  }

  @override
  WalletAddress get fromAddress => delegatorWalletAddress;

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valkey, tokenAmountModels];
}
