import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_delegate_form/staking_msg_delegate_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class StakingTxDelegateFormDialog extends StatefulWidget {
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final ValueChanged<SignedTxModel> onTxFormCompleted;

  const StakingTxDelegateFormDialog({
    required this.stakingMsgDelegateFormModel,
    required this.feeTokenAmountModel,
    required this.onTxFormCompleted,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingTxDelegateFormDialog();
}

class _StakingTxDelegateFormDialog extends State<StakingTxDelegateFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).stakingTxDelegateTokens,
      child: Column(
        children: <Widget>[
          StakingMsgDelegateForm(
            formKey: formKey,
            stakingMsgDelegateFormModel: widget.stakingMsgDelegateFormModel,
            feeTokenAmountModel: widget.feeTokenAmountModel,
          ),
          const SizedBox(height: 30),
          TxSendFormFooter(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgFormModel: widget.stakingMsgDelegateFormModel,
            onSubmit: widget.onTxFormCompleted,
          ),
        ],
      ),
    );
  }
}
