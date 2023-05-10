import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_downloading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_empty_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/a_msg_form_controller.dart';

class TxFormBuilderCubit extends Cubit<ATxFormBuilderState> {
  final AuthCubit _authCubit = globalLocator<AuthCubit>();
  final QueryAccountService _queryAccountService = globalLocator<QueryAccountService>();

  final TokenAmountModel feeTokenAmountModel;
  final AMsgFormController msgFormController;

  TxFormBuilderCubit({
    required this.feeTokenAmountModel,
    required this.msgFormController,
  }) : super(TxFormBuilderEmptyState());

  /// Method [buildUnsignedTx] throws [Exception] if one of the methods [_buildTxLocalInfo], [_downloadTxRemoteInfo] throws an exception
  /// Detailed explanation should be above these methods
  Future<UnsignedTxModel> buildUnsignedTx() async {
    emit(TxFormBuilderDownloadingState());

    try {
      TxLocalInfoModel txLocalInfoModel = _buildTxLocalInfo();
      TxRemoteInfoModel txRemoteInfoModel = await _downloadTxRemoteInfo();

      emit(TxFormBuilderEmptyState());

      UnsignedTxModel unsignedTxModel = UnsignedTxModel(
        txLocalInfoModel: txLocalInfoModel,
        txRemoteInfoModel: txRemoteInfoModel,
      );
      return unsignedTxModel;
    } catch (e) {
      emit(TxFormBuilderErrorState());
      rethrow;
    }
  }

  /// Method [msgFormController.buildTxMsgModel] may throw an [Exception] if cannot create [ATxMsgModel]
  /// The most common reason is when all required fields in form were not filled
  TxLocalInfoModel _buildTxLocalInfo() {
    ATxMsgModel txMsgModel = msgFormController.buildTxMsgModel();
    String memo = msgFormController.memo;
    TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
      feeTokenAmountModel: feeTokenAmountModel,
      memo: memo,
      txMsgModel: txMsgModel,
    );
    return txLocalInfoModel;
  }

  /// Throws [Exception] if cannot download [TxRemoteInfoModel]
  /// e.g. no network connection, Interx has an unsupported version
  Future<TxRemoteInfoModel> _downloadTxRemoteInfo() async {
    assert(_authCubit.isSignedIn, 'Wallet public address must be provided to use this method');
    try {
      TxRemoteInfoModel txRemoteInfoModel = await _queryAccountService.getTxRemoteInfo(_authCubit.state!.address.bech32Address);
      return txRemoteInfoModel;
    } on DioError catch (e) {
      throw Exception('Cannot download TxRemoteInfoModel: ${e.message}');
    } catch (e) {
      throw Exception('Cannot parse TxRemoteInfoModel: ${e}');
    }
  }
}
