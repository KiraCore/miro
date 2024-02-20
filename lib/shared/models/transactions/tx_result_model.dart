class TxResultModel extends Equatable {
  final String hash;
  final DateTime time;
  final TxDirectionType txDirectionType;
  final TxStatusType txStatusType;
  final List<ATxMsgModel> txMsgModels;
  final List<TokenAmountModel> fees;
  final List<PrefixedTokenAmountModel> prefixedTokenAmounts;
}