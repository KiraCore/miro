import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_request_verification_form/ir_msg_request_verification_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class IRTxRequestVerificationConfirmDialog extends StatelessWidget {
  final TxProcessCubit<IRMsgRequestVerificationFormModel> txProcessCubit;
  final TxLocalInfoModel txLocalInfoModel;
  final IRMsgRequestVerificationFormModel irMsgRequestVerificationFormModel;

  const IRTxRequestVerificationConfirmDialog({
    required this.txProcessCubit,
    required this.txLocalInfoModel,
    required this.irMsgRequestVerificationFormModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<IRMsgRequestVerificationFormModel>(
      title: S.of(context).irTxTitleConfirmVerificationRequest,
      formPreviewWidget: IRMsgRequestVerificationFormPreview(
        irMsgRequestVerificationFormModel: irMsgRequestVerificationFormModel,
        txLocalInfoModel: txLocalInfoModel,
      ),
    );
  }
}
