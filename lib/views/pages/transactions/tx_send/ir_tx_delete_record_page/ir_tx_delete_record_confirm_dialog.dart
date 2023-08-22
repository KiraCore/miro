import 'package:flutter/cupertino.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_delete_records_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_delete_records_form/ir_msg_delete_records_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class IRTxDeleteRecordConfirmDialog extends StatelessWidget {
  final TxLocalInfoModel txLocalInfoModel;
  final IRMsgDeleteRecordsFormModel irMsgDeleteRecordsFormModel;

  const IRTxDeleteRecordConfirmDialog({
    required this.txLocalInfoModel,
    required this.irMsgDeleteRecordsFormModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<IRMsgDeleteRecordsFormModel>(
      title: S.of(context).irTxConfirmDeleteRecord,
      editButtonVisibleBool: false,
      formPreviewWidget: IRMsgDeleteRecordsFormPreview(
        txLocalInfoModel: txLocalInfoModel,
        irMsgDeleteRecordsFormModel: irMsgDeleteRecordsFormModel,
      ),
    );
  }
}
