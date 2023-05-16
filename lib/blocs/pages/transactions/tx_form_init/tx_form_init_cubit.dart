import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/tx_form_init/a_tx_form_init_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_init/states/tx_form_init_downloading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_init/states/tx_form_init_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_init/states/tx_form_init_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

class TxFormInitCubit extends Cubit<ATxFormInitState> {
  final QueryExecutionFeeService _queryExecutionFeeService = globalLocator<QueryExecutionFeeService>();

  final TxMsgType txMsgType;

  TxFormInitCubit({
    required this.txMsgType,
  }) : super(TxFormInitDownloadingState());

  Future<void> downloadTxFee() async {
    try {
      emit(TxFormInitDownloadingState());
      String messageName = InterxMsgTypes.getName(txMsgType);
      TokenAmountModel feeTokenAmountModel = await _queryExecutionFeeService.getExecutionFeeForMessage(messageName);
      emit(TxFormInitLoadedState(feeTokenAmountModel: feeTokenAmountModel));
    } catch (e) {
      AppLogger().log(message: 'Cannot load tx fee. Error: $e', logLevel: LogLevel.error);
      emit(TxFormInitErrorState());
    }
  }
}
