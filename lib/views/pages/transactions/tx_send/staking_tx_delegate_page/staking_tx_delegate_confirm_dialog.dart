import 'package:flutter/cupertino.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_delegate_form/staking_msg_delegate_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class StakingTxDelegateConfirmDialog extends StatelessWidget {
  final String moniker;
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;
  final WalletAddress validatorWalletAddress;

  const StakingTxDelegateConfirmDialog({
    required this.moniker,
    required this.stakingMsgDelegateFormModel,
    required this.txLocalInfoModel,
    required this.validatorWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<StakingMsgDelegateFormModel>(
      title: S.of(context).stakingTxConfirmStaking,
      formPreviewWidget: StakingMsgDelegateFormPreview(
        moniker: moniker,
        stakingMsgDelegateFormModel: stakingMsgDelegateFormModel,
        txLocalInfoModel: txLocalInfoModel,
        validatorWalletAddress: validatorWalletAddress,
      ),
    );
  }
}
