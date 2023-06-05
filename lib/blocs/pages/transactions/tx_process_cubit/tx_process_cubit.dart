import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loading_state.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class TxProcessCubit<T extends AMsgFormModel> extends Cubit<ATxProcessState> {
  final QueryExecutionFeeService _queryExecutionFeeService = QueryExecutionFeeService();

  final TxMsgType txMsgType;
  final T msgFormModel;

  TxProcessCubit({
    required this.txMsgType,
    required this.msgFormModel,
  }) : super(const TxProcessLoadingState());

  Future<void> init() async {
    emit(const TxProcessLoadingState());

    String msgTypeName = InterxMsgTypes.getName(txMsgType);
    try {
      TokenAmountModel feeTokenAmountModel = await _queryExecutionFeeService.getExecutionFeeForMessage(msgTypeName);
      emit(TxProcessLoadedState(feeTokenAmountModel: feeTokenAmountModel));
    } catch (_) {
      AppLogger().log(message: 'Failed to load transaction fee');
      emit(const TxProcessErrorState());
    }
  }
  
  void submitTransactionForm(SignedTxModel signedTxModel) {
    if (state is TxProcessLoadedState) {
      emit(TxProcessConfirmState(
        txProcessLoadedState: state as TxProcessLoadedState,
        signedTxModel: signedTxModel,
      ));
    }
  }

  Future<void> confirmTransactionForm() async {
    if (state is TxProcessConfirmState == false) {
      return;
    }
    TxProcessConfirmState txProcessConfirmState = state as TxProcessConfirmState;
    emit(TxProcessBroadcastState(
      txProcessLoadedState: txProcessConfirmState.txProcessLoadedState,
      signedTxModel: txProcessConfirmState.signedTxModel,
    ));
  }

  Future<void> editTransactionForm() async {
    TxProcessLoadedState? txProcessLoadedState;
    if (state is TxProcessBroadcastState) {
      txProcessLoadedState = (state as TxProcessBroadcastState).txProcessLoadedState;
    } else if (state is TxProcessConfirmState) {
      txProcessLoadedState = (state as TxProcessConfirmState).txProcessLoadedState;
    } else if (state is TxProcessLoadedState) {
      txProcessLoadedState = state as TxProcessLoadedState;
    }
    if (txProcessLoadedState != null) {
      emit(txProcessLoadedState);
    }
  }
}
