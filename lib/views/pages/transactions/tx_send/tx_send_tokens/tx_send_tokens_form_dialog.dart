import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/msg_send_form/msg_send_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class TxSendTokensFormDialog extends StatefulWidget {
  final MsgSendFormModel msgSendFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final ValueChanged<SignedTxModel> onTxFormCompleted;

  const TxSendTokensFormDialog({
    required this.msgSendFormModel,
    required this.feeTokenAmountModel,
    required this.onTxFormCompleted,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendTokensFormDialog();
}

class _TxSendTokensFormDialog extends State<TxSendTokensFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).txSendTokens,
      child: Column(
        children: <Widget>[
          MsgSendForm(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgSendFormModel: widget.msgSendFormModel,
          ),
          const SizedBox(height: 30),
          TxSendFormFooter(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgFormModel: widget.msgSendFormModel,
            onSubmit: widget.onTxFormCompleted,
          ),
        ],
      ),
    );
  }
}
