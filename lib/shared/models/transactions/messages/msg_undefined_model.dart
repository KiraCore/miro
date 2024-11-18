part of 'a_tx_msg_model.dart';

class MsgUndefinedModel extends ATxMsgModel {
  const MsgUndefinedModel() : super(txMsgType: TxMsgType.undefined);

  @override
  MsgUndefined toMsgDto() {
    return const MsgUndefined();
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
  List<Object?> get props => <Object>[];
}
