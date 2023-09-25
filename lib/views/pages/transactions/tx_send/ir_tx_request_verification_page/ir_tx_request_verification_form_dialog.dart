import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_request_verification_form/ir_msg_request_verification_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class IRTxRequestVerificationFormDialog extends StatefulWidget {
  final IRMsgRequestVerificationFormModel irMsgRequestVerificationFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final TokenAmountModel minTipTokenAmountModel;
  final ValueChanged<SignedTxModel> onTxFormCompleted;

  const IRTxRequestVerificationFormDialog({
    required this.irMsgRequestVerificationFormModel,
    required this.feeTokenAmountModel,
    required this.minTipTokenAmountModel,
    required this.onTxFormCompleted,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxRequestIdentityRecordVerifyFormDialog();
}

class _TxRequestIdentityRecordVerifyFormDialog extends State<IRTxRequestVerificationFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).irTxTitleRequestIdentityRecordVerification,
      child: Column(
        children: <Widget>[
          IRMsgRequestVerificationForm(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            minTipTokenAmountModel: widget.minTipTokenAmountModel,
            irMsgRequestVerificationFormModel: widget.irMsgRequestVerificationFormModel,
          ),
          const SizedBox(height: 30),
          TxSendFormFooter(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgFormModel: widget.irMsgRequestVerificationFormModel,
            onSubmit: widget.onTxFormCompleted,
          ),
        ],
      ),
    );
  }
}
