import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_register_record_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_register_record_page/ir_tx_register_record_confirm_dialog.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_register_record_page/ir_tx_register_record_form_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

class IRTxRegisterRecordPage extends StatefulWidget {
  final bool irKeyEditableBool;
  final IRRecordModel? irRecordModel;
  final int? irValueMaxLength;

  const IRTxRegisterRecordPage({
    required this.irKeyEditableBool,
    required this.irRecordModel,
    this.irValueMaxLength,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRTxRegisterRecordPage();
}

class _IRTxRegisterRecordPage extends State<IRTxRegisterRecordPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<IRMsgRegisterRecordFormModel> txProcessCubit = TxProcessCubit<IRMsgRegisterRecordFormModel>(
    txMsgType: TxMsgType.msgRegisterIdentityRecords,
    msgFormModel: IRMsgRegisterRecordFormModel(
      identityKey: widget.irRecordModel?.key,
      identityValue: widget.irRecordModel?.value,
      senderWalletAddress: authCubit.state?.address,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<IRMsgRegisterRecordFormModel>(
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: (TxProcessLoadedState txProcessLoadedState) {
        return IRTxRegisterRecordFormDialog(
          irKeyEditableBool: widget.irKeyEditableBool,
          feeTokenAmountModel: txProcessLoadedState.feeTokenAmountModel,
          irMsgRegisterRecordFormModel: txProcessCubit.msgFormModel,
          irValueMaxLength: widget.irValueMaxLength,
          onTxFormCompleted: txProcessCubit.submitTransactionForm,
        );
      },
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return IRTxRegisterRecordConfirmDialog(
          txProcessCubit: txProcessCubit,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          irMsgRegisterRecordFormModel: txProcessCubit.msgFormModel,
        );
      },
    );
  }
}
