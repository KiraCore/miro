import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_rewards_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_claim_rewards_form/staking_msg_claim_rewards_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class StakingTxClaimRewardsConfirmDialog extends StatelessWidget {
  final TxLocalInfoModel txLocalInfoModel;
  final StakingMsgClaimRewardsFormModel stakingMsgClaimRewardsFormModel;

  const StakingTxClaimRewardsConfirmDialog({
    required this.txLocalInfoModel,
    required this.stakingMsgClaimRewardsFormModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<StakingMsgClaimRewardsFormModel>(
      title: S.of(context).stakingTxClaimRewards,
      editButtonVisibleBool: false,
      formPreviewWidget: StakingMsgClaimRewardsFormPreview(
        txLocalInfoModel: txLocalInfoModel,
        stakingMsgClaimRewardsFormModel: stakingMsgClaimRewardsFormModel,
      ),
    );
  }
}
