part of '../a_tx_msg_model.dart';

class StakingMsgUndelegateModel extends ATxMsgModel {
  final String valkey;
  final WalletAddress delegatorWalletAddress;
  final List<TokenAmountModel> tokenAmountModels;

  const StakingMsgUndelegateModel({
    required this.valkey,
    required this.delegatorWalletAddress,
    required this.tokenAmountModels,
  }) : super(txMsgType: TxMsgType.msgUndelegate);

  StakingMsgUndelegateModel.single({
    required this.valkey,
    required this.delegatorWalletAddress,
    required TokenAmountModel tokenAmountModel,
  })  : tokenAmountModels = <TokenAmountModel>[tokenAmountModel],
        super(txMsgType: TxMsgType.msgUndelegate);

  factory StakingMsgUndelegateModel.fromMsgDto(MsgUndelegate msgUndelegate) {
    return StakingMsgUndelegateModel(
      valkey: msgUndelegate.valoperAddress,
      delegatorWalletAddress: WalletAddress.fromBech32(msgUndelegate.delegatorAddress),
      tokenAmountModels: msgUndelegate.amounts
          .map((CosmosCoin coin) => TokenAmountModel(
                defaultDenominationAmount: Decimal.fromBigInt(coin.amount),
                tokenAliasModel: TokenAliasModel.local(coin.denom),
              ))
          .toList(),
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgUndelegate(
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
    return const Icon(Icons.money_off);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return tokenAmountModels
        .map((TokenAmountModel e) => PrefixedTokenAmountModel(tokenAmountModel: e, tokenAmountPrefixType: TokenAmountPrefixType.add))
        .toList();
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return valkey;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgUndelegate;
  }

  @override
  List<Object?> get props => <Object>[delegatorWalletAddress, valkey, tokenAmountModels];
}
