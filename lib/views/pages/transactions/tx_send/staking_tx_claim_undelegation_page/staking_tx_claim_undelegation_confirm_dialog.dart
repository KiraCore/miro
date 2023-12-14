import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_undelegation_form_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_claim_undelegation_form/staking_msg_claim_undelegation_form_preview.dart';
import 'package:miro/views/widgets/transactions/send/tx_dialog_confirm_layout.dart';

class StakingTxClaimUndelegationConfirmDialog extends StatelessWidget {
  final TokenAmountModel tokenAmountModel;
  final StakingMsgClaimUndelegationFormModel stakingMsgClaimUndelegationFormModel;
  final TxLocalInfoModel txLocalInfoModel;
  final WalletAddress validatorWalletAddress;

  const StakingTxClaimUndelegationConfirmDialog({
    required this.tokenAmountModel,
    required this.stakingMsgClaimUndelegationFormModel,
    required this.txLocalInfoModel,
    required this.validatorWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialogConfirmLayout<StakingMsgClaimUndelegationFormModel>(
      title: S.of(context).stakingTxClaimUnstaked,
      editButtonVisibleBool: false,
      formPreviewWidget: StakingMsgClaimUndelegationFormPreview(
        amountToClaim: tokenAmountModel,
        txLocalInfoModel: txLocalInfoModel,
        stakingMsgClaimUndelegationFormModel: stakingMsgClaimUndelegationFormModel,
        validatorWalletAddress: validatorWalletAddress,
      ),
    );
  }
}
