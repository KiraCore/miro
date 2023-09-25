import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_register_record_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_register_record_form/ir_msg_register_record_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class IRTxRegisterRecordFormDialog extends StatefulWidget {
  final bool irKeyEditableBool;
  final IRMsgRegisterRecordFormModel irMsgRegisterRecordFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final ValueChanged<SignedTxModel> onTxFormCompleted;
  final int? irValueMaxLength;

  const IRTxRegisterRecordFormDialog({
    required this.irKeyEditableBool,
    required this.irMsgRegisterRecordFormModel,
    required this.feeTokenAmountModel,
    required this.onTxFormCompleted,
    this.irValueMaxLength,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRTxRegisterRecordFormDialog();
}

class _IRTxRegisterRecordFormDialog extends State<IRTxRegisterRecordFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).irTxTitleRegisterIdentityRecord,
      child: Column(
        children: <Widget>[
          IRMsgRegisterRecordForm(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            irKeyEditableBool: widget.irKeyEditableBool,
            irMsgRegisterRecordFormModel: widget.irMsgRegisterRecordFormModel,
            irValueMaxLength: widget.irValueMaxLength,
            initialIdentityKey: widget.irMsgRegisterRecordFormModel.identityKey,
            initialIdentityValue: widget.irMsgRegisterRecordFormModel.identityValue,
            initialWalletAddress: widget.irMsgRegisterRecordFormModel.senderWalletAddress,
          ),
          const SizedBox(height: 30),
          TxSendFormFooter(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgFormModel: widget.irMsgRegisterRecordFormModel,
            onSubmit: widget.onTxFormCompleted,
          ),
        ],
      ),
    );
  }
}
