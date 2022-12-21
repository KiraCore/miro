import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';

class TxBroadcastCubit extends Cubit<ATxBroadcastState> {
  final BroadcastService broadcastService = globalLocator<BroadcastService>();
  final ReloadNotifierController reloadNotifierController = globalLocator<ReloadNotifierController>();

  TxBroadcastCubit() : super(TxBroadcastLoadingState());

  Future<void> broadcast(SignedTxModel signedTxModel) async {
    emit(TxBroadcastLoadingState());
    try {
      BroadcastRespModel broadcastRespModel = await broadcastService.broadcastTx(signedTxModel);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      reloadNotifierController.myAccountBalanceListNotifier.reload();
      emit(TxBroadcastCompletedState(broadcastRespModel: broadcastRespModel));
    } catch (_) {
      emit(TxBroadcastErrorState());
    }
  }
}
