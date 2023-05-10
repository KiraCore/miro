import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/exceptions/tx_broadcast_exception.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';
import 'package:miro/shared/models/network/error_explorer_model.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';

class TxBroadcastCubit extends Cubit<ATxBroadcastState> {
  final ReloadNotifierController reloadNotifierController = globalLocator<ReloadNotifierController>();
  final BroadcastService broadcastService = globalLocator<BroadcastService>();

  TxBroadcastCubit() : super(TxBroadcastLoadingState());

  Future<void> broadcast(SignedTxModel signedTxModel) async {
    emit(TxBroadcastLoadingState());
    try {
      BroadcastRespModel broadcastRespModel = await broadcastService.broadcastTx(signedTxModel);
      reloadNotifierController.myAccountBalanceListNotifier.reload();
      emit(TxBroadcastCompletedState(broadcastRespModel: broadcastRespModel));
    } on DioConnectException catch (dioConnectException) {
      ErrorExplorerModel errorExplorerModel = ErrorExplorerModel.fromDioConnectException(dioConnectException);
      emit(TxBroadcastErrorState(errorExplorerModel: errorExplorerModel));
    } on DioParseException catch (dioParseException) {
      ErrorExplorerModel errorExplorerModel = ErrorExplorerModel.fromDioParseException(dioParseException);
      emit(TxBroadcastErrorState(errorExplorerModel: errorExplorerModel));
    } on TxBroadcastException catch (txBroadcastException) {
      RequestOptions requestOptions = txBroadcastException.response.requestOptions;

      ErrorExplorerModel errorExplorerModel = ErrorExplorerModel(
        code: txBroadcastException.broadcastErrorLogModel.code,
        message: txBroadcastException.broadcastErrorLogModel.message,
        uri: requestOptions.uri,
        method: requestOptions.method,
        request: requestOptions.data,
        response: txBroadcastException.response.data,
      );
      emit(TxBroadcastErrorState(errorExplorerModel: errorExplorerModel));
    }
  }
}
