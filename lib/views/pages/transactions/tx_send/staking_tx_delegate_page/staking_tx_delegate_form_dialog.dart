import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_delegate_form/staking_msg_delegate_form.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class StakingTxDelegateFormDialog extends StatefulWidget {
  final TokenAmountModel feeTokenAmountModel;
  final bool Function(BalanceModel) initialFilterComparator;
  final ValueChanged<SignedTxModel> onTxFormCompleted;
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const StakingTxDelegateFormDialog({
    required this.feeTokenAmountModel,
    required this.initialFilterComparator,
    required this.onTxFormCompleted,
    required this.stakingMsgDelegateFormModel,
    required this.validatorSimplifiedModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingTxDelegateFormDialog();
}

class _StakingTxDelegateFormDialog extends State<StakingTxDelegateFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: S.of(context).stakingTxStakeTokens,
      child: Column(
        children: <Widget>[
          StakingMsgDelegateForm(
            formKey: formKey,
            stakingMsgDelegateFormModel: widget.stakingMsgDelegateFormModel,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            initialFilterComparator: widget.initialFilterComparator,
            validatorSimplifiedModel: widget.validatorSimplifiedModel,
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
