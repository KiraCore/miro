import 'package:flutter/cupertino.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_handle_verification_request_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_handle_verification_request_form/ir_msg_handle_verification_request_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class IRTxHandleVerificationRequestConfirmDialog extends StatelessWidget {
  final bool approvalStatusBool;
  final TxLocalInfoModel txLocalInfoModel;
  final IRMsgHandleVerificationRequestFormModel irMsgHandleVerificationRequestFormModel;

  const IRTxHandleVerificationRequestConfirmDialog({
    required this.approvalStatusBool,
    required this.txLocalInfoModel,
    required this.irMsgHandleVerificationRequestFormModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<IRMsgHandleVerificationRequestFormModel>(
      title: approvalStatusBool ? S.of(context).irVerificationRequestsConfirmApproval : S.of(context).irVerificationRequestsConfirmRejection,
      editButtonVisibleBool: false,
      formPreviewWidget: IRMsgHandleVerificationRequestFormPreview(
        txLocalInfoModel: txLocalInfoModel,
        irMsgHandleVerificationRequestFormModel: irMsgHandleVerificationRequestFormModel,
      ),
    );
  }
}
