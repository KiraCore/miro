import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_rewards_form_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_rewards_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class StakingMsgClaimRewardsFormPreview extends StatefulWidget {
  final StakingMsgClaimRewardsFormModel stakingMsgClaimRewardsFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  StakingMsgClaimRewardsFormPreview({
    required this.stakingMsgClaimRewardsFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is StakingMsgClaimRewardsModel, 'ITxMsgModel must be an instance of StakingMsgClaimRewardsModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingMsgClaimRewardsFormPreview();
}

class _StakingMsgClaimRewardsFormPreview extends State<StakingMsgClaimRewardsFormPreview> {
  late final StakingMsgClaimRewardsModel stakingMsgClaimRewardsModel = widget.txLocalInfoModel.txMsgModel as StakingMsgClaimRewardsModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintClaimTo,
          value: stakingMsgClaimRewardsModel.senderWalletAddress.address,
          icon: KiraIdentityAvatar(
            address: stakingMsgClaimRewardsModel.senderWalletAddress.address,
            size: 45,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 12),
        Text(
          S.of(context).txNoticeFee(_feeAmountText),
          style: textTheme.bodySmall!.copyWith(color: DesignColors.white1),
        ),
      ],
    );
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }
}
