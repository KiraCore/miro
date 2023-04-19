import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';

class TxLocalInfoModel extends Equatable {
  final String memo;
  final TokenAmountModel feeTokenAmountModel;
  final ATxMsgModel txMsgModel;

  const TxLocalInfoModel({
    required this.memo,
    required this.feeTokenAmountModel,
    required this.txMsgModel,
  });

  String get replacedMemo => TxUtils.replaceMemoRestrictedChars(memo);

  @override
  List<Object?> get props => <Object>[memo, feeTokenAmountModel, txMsgModel];
}
