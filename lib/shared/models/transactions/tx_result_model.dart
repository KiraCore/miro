import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';

class TxResultModel extends Equatable {
  final String hash;
  final DateTime time;
  final TxDirectionType txDirectionType;
  final TxStatusType txStatusType;
  final List<ATxMsgModel> txMsgModels;
  final List<TokenAmountModel> fees;
  final List<PrefixedTokenAmountModel> prefixedTokenAmounts;
}
