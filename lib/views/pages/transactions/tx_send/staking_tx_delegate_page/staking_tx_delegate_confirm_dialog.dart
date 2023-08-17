import 'package:flutter/cupertino.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_delegate_form/staking_msg_delegate_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class StakingTxDelegateConfirmDialog extends StatelessWidget {
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  const StakingTxDelegateConfirmDialog({
    required this.stakingMsgDelegateFormModel,
    required this.txLocalInfoModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<StakingMsgDelegateFormModel>(
      title: S.of(context).stakingTxDelegateConfirm,
      formPreviewWidget: StakingMsgDelegateFormPreview(
        stakingMsgDelegateFormModel: stakingMsgDelegateFormModel,
        txLocalInfoModel: txLocalInfoModel,
      ),
    );
  }
}
