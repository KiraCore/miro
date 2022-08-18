import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';

class TxLocalInfoModel extends Equatable {
  final TokenAmountModel feeTokenAmountModel;
  final String memo;
  final ITxMsgModel txMsgModel;

  const TxLocalInfoModel({
    required this.feeTokenAmountModel,
    required this.memo,
    required this.txMsgModel,
  });

  @override
  List<Object?> get props => <Object>[feeTokenAmountModel, memo, txMsgModel];
}
