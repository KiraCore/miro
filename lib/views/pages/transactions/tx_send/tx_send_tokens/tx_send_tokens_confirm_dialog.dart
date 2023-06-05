import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/msg_send_form/msg_send_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class TxSendTokensConfirmDialog extends StatelessWidget {
  final MsgSendFormModel msgSendFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  const TxSendTokensConfirmDialog({
    required this.msgSendFormModel,
    required this.txLocalInfoModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<MsgSendFormModel>(
      formPreviewWidget: MsgSendFormPreview(
        msgSendFormModel: msgSendFormModel,
        txLocalInfoModel: txLocalInfoModel,
      ),
    );
  }
}
