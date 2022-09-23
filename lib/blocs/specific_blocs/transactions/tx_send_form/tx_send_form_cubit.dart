import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/a_tx_send_form_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_building_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_building_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_init_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

class TxSendFormCubit extends Cubit<ATxSendFormState> {
  final WalletProvider _walletProvider = globalLocator<WalletProvider>();
  final QueryAccountService _queryAccountService = globalLocator<QueryAccountService>();
  final QueryNetworkPropertiesService _queryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  TxSendFormCubit() : super(TxSendFormInitState());

  Future<void> loadTxFee() async {
    try {
      emit(TxSendFormInitState());
      TokenAmountModel feeTokenAmountModel = await _queryNetworkPropertiesService.getTxFee();
      emit(TxSendFormLoadedState(feeTokenAmountModel: feeTokenAmountModel));
    } catch (e) {
      AppLogger().log(message: 'Cannot load tx fee. Error: $e', logLevel: LogLevel.error);
      emit(TxSendFormErrorState());
    }
  }

  Future<UnsignedTxModel?> buildTx(TxLocalInfoModel txLocalInfoModel) async {
    assert(state is TxSendFormLoadedState, 'TxSendFormCubit.buildTx: state must be TxSendFormLoadedState to use this method');

    TxSendFormLoadedState txSendFormLoadedState = state as TxSendFormLoadedState;
    TokenAmountModel feeTokenAmountModel = txSendFormLoadedState.feeTokenAmountModel;
    emit(TxSendFormBuildingState(feeTokenAmountModel: feeTokenAmountModel));

    TxRemoteInfoModel? txRemoteInfoModel = await _getTxRemoteInfoModel();

    if (txRemoteInfoModel == null) {
      emit(TxSendFormBuildingErrorState(feeTokenAmountModel: feeTokenAmountModel));
      return null;
    } else {
      emit(TxSendFormLoadedState(feeTokenAmountModel: feeTokenAmountModel));
      return UnsignedTxModel(
        txLocalInfoModel: txLocalInfoModel,
        txRemoteInfoModel: txRemoteInfoModel,
      );
    }
  }

  Future<TxRemoteInfoModel?> _getTxRemoteInfoModel() async {
    assert(_walletProvider.isLoggedIn, 'TxSendFormCubit.buildTx: user must be logged in to use this method');
    try {
      TxRemoteInfoModel txRemoteInfoModel = await _queryAccountService.getTxRemoteInfo(_walletProvider.currentWallet!.address.bech32Address);
      return txRemoteInfoModel;
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch TxRemoteInfoModel. Error: $e', logLevel: LogLevel.error);
      return null;
    }
  }
}
