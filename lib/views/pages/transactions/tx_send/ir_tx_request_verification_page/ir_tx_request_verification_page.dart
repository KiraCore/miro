import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_request_verification_page/ir_tx_request_verification_confirm_dialog.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_request_verification_page/ir_tx_request_verification_form_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

class IRTxRequestVerificationPage extends StatefulWidget {
  final IRRecordModel irRecordModel;

  const IRTxRequestVerificationPage({
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRTxRequestVerificationPage();
}

class _IRTxRequestVerificationPage extends State<IRTxRequestVerificationPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<IRMsgRequestVerificationFormModel> txProcessCubit = TxProcessCubit<IRMsgRequestVerificationFormModel>(
    txMsgType: TxMsgType.msgRequestIdentityRecordsVerify,
    msgFormModel: IRMsgRequestVerificationFormModel(
      requesterWalletAddress: authCubit.state?.address,
      irRecordModel: widget.irRecordModel,
    ),
  );

  @override
  void dispose() {
    txProcessCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<IRMsgRequestVerificationFormModel>(
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: (TxProcessLoadedState txProcessLoadedState) {
        if (authCubit.state == null) {
          return const SizedBox();
        }

        return IRTxRequestVerificationFormDialog(
          feeTokenAmountModel: txProcessLoadedState.feeTokenAmountModel,
          onTxFormCompleted: txProcessCubit.submitTransactionForm,
          minTipTokenAmountModel: txProcessLoadedState.networkPropertiesModel.minIdentityApprovalTip,
          irMsgRequestVerificationFormModel: txProcessCubit.msgFormModel,
        );
      },
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return IRTxRequestVerificationConfirmDialog(
          txProcessCubit: txProcessCubit,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          irMsgRequestVerificationFormModel: txProcessCubit.msgFormModel,
        );
      },
    );
  }
}
