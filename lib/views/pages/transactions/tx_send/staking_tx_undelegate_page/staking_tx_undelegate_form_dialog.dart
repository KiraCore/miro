import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_undelegate_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_undelegate_form/staking_msg_undelegate_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class StakingTxUndelegateFormDialog extends StatefulWidget {
  final TokenAmountModel feeTokenAmountModel;
  final ValueChanged<SignedTxModel> onTxFormCompleted;
  final StakingMsgUndelegateFormModel stakingMsgUndelegateFormModel;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const StakingTxUndelegateFormDialog({
    required this.feeTokenAmountModel,
    required this.onTxFormCompleted,
    required this.stakingMsgUndelegateFormModel,
    required this.validatorSimplifiedModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingTxUndelegateFormDialog();
}

class _StakingTxUndelegateFormDialog extends State<StakingTxUndelegateFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).unstakeTokens,
      child: Column(
        children: <Widget>[
          StakingMsgUndelegateForm(
            formKey: formKey,
            stakingMsgUndelegateFormModel: widget.stakingMsgUndelegateFormModel,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            validatorSimplifiedModel: widget.validatorSimplifiedModel,
          ),
          const SizedBox(height: 30),
          TxSendFormFooter(
            formKey: formKey,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            msgFormModel: widget.stakingMsgUndelegateFormModel,
            onSubmit: widget.onTxFormCompleted,
          ),
        ],
      ),
    );
  }
}
