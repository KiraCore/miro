import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_register_record_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_register_record_form/ir_msg_register_record_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class IRTxRegisterRecordConfirmDialog extends StatelessWidget {
  final TxProcessCubit<IRMsgRegisterRecordFormModel> txProcessCubit;
  final TxLocalInfoModel txLocalInfoModel;
  final IRMsgRegisterRecordFormModel irMsgRegisterRecordFormModel;

  const IRTxRegisterRecordConfirmDialog({
    required this.txProcessCubit,
    required this.txLocalInfoModel,
    required this.irMsgRegisterRecordFormModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<IRMsgRegisterRecordFormModel>(
      formPreviewWidget: IRMsgRegisterRecordFormPreview(txLocalInfoModel: txLocalInfoModel),
    );
  }
}
