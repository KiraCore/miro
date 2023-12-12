import 'package:flutter/cupertino.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_undelegate_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_undelegate_form/staking_msg_undelegate_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class StakingTxUndelegateConfirmDialog extends StatelessWidget {
  final String moniker;
  final StakingMsgUndelegateFormModel stakingMsgDelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;
  final WalletAddress validatorWalletAddress;

  const StakingTxUndelegateConfirmDialog({
    required this.moniker,
    required this.stakingMsgDelegateFormModel,
    required this.txLocalInfoModel,
    required this.validatorWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<StakingMsgUndelegateFormModel>(
      title: S.of(context).stakingTxConfirmUnstake,
      formPreviewWidget: StakingMsgUndelegateFormPreview(
        moniker: moniker,
        stakingMsgUndelegateFormModel: stakingMsgDelegateFormModel,
        txLocalInfoModel: txLocalInfoModel,
        validatorWalletAddress: validatorWalletAddress,
      ),
    );
  }
}
