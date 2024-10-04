import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_broadcast_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/shared/models/network/network_properties_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class TxProcessCubit<T extends AMsgFormModel> extends Cubit<ATxProcessState> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final QueryAccountService _queryAccountService = globalLocator<QueryAccountService>();
  final QueryExecutionFeeService _queryExecutionFeeService = globalLocator<QueryExecutionFeeService>();
  final QueryNetworkPropertiesService _queryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  final TxMsgType txMsgType;
  final T msgFormModel;

  TxProcessCubit({
    required this.txMsgType,
    required this.msgFormModel,
  }) : super(const TxProcessLoadingState());

  Future<void> init({bool formEnabledBool = true}) async {
    emit(const TxProcessLoadingState());

    if (authCubit.isSignedIn == false) {
      emit(const TxProcessErrorState());
      return;
    }

    String msgTypeName = InterxMsgTypes.getName(txMsgType);

    try {
      bool txRemoteInfoAvailableBool = await _queryAccountService.isAccountRegistered(authCubit.identityStateAddress!.address);
      if (txRemoteInfoAvailableBool == false) {
        emit(const TxProcessErrorState(accountErrorBool: true));
        return;
      }
      TokenAmountModel feeTokenAmountModel = await _queryExecutionFeeService.getExecutionFeeForMessage(msgTypeName);
      NetworkPropertiesModel networkPropertiesModel = await _queryNetworkPropertiesService.getNetworkProperties();
      TxProcessLoadedState txProcessLoadedState = TxProcessLoadedState(
        feeTokenAmountModel: feeTokenAmountModel,
        networkPropertiesModel: networkPropertiesModel,
      );
      if (formEnabledBool) {
        emit(txProcessLoadedState);
        return;
      }

      SignedTxModel signedTxModel = await _buildSignedTransaction(feeTokenAmountModel);
      if (isClosed == false) {
        emit(TxProcessConfirmState(
          txProcessLoadedState: txProcessLoadedState,
          signedTxModel: signedTxModel,
        ));
      }
    } catch (e) {
      if (isClosed == false) {
        AppLogger().log(message: 'Failed to load transaction fee: $e');
        emit(const TxProcessErrorState());
      }
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

  Future<SignedTxModel> _buildSignedTransaction(TokenAmountModel feeTokenAmountModel) async {
    TxFormBuilderCubit txFormBuilderCubit = TxFormBuilderCubit(
      feeTokenAmountModel: feeTokenAmountModel,
      msgFormModel: msgFormModel,
    );

    UnsignedTxModel unsignedTxModel = await txFormBuilderCubit.buildUnsignedTx();
    SignedTxModel signedTxModel = await _signTransaction(unsignedTxModel);
    return signedTxModel;
  }

  Future<SignedTxModel> _signTransaction(UnsignedTxModel unsignedTxModel) async {
    Wallet? wallet = authCubit.state;
    if (wallet == null) {
      throw Exception('Wallet cannot be null when signing transaction');
    }
    return unsignedTxModel.sign(wallet);
  }
}
