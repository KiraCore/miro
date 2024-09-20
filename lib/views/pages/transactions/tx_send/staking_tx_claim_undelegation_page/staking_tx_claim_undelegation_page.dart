import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_undelegation_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/views/pages/transactions/tx_send/staking_tx_claim_undelegation_page/staking_tx_claim_undelegation_confirm_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

@RoutePage()
class StakingTxClaimUndelegationPage extends StatefulWidget {
  final int undelegationId;
  final TokenAmountModel tokenAmountModel;
  final AWalletAddress validatorWalletAddress;

  const StakingTxClaimUndelegationPage({
    required this.undelegationId,
    required this.tokenAmountModel,
    required this.validatorWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StakingTxClaimUndelegationPage> createState() => _StakingTxClaimUndelegationPageState();
}

class _StakingTxClaimUndelegationPageState extends State<StakingTxClaimUndelegationPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<StakingMsgClaimUndelegationFormModel> txProcessCubit = TxProcessCubit<StakingMsgClaimUndelegationFormModel>(
    txMsgType: TxMsgType.msgClaimUndelegation,
    msgFormModel: StakingMsgClaimUndelegationFormModel(
        senderWalletAddress: authCubit.state?.address,
        undelegationId: widget.undelegationId.toString(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<StakingMsgClaimUndelegationFormModel>(
      formEnabledBool: false,
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: null,
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return StakingTxClaimUndelegationConfirmDialog(
          tokenAmountModel: widget.tokenAmountModel,
          stakingMsgClaimUndelegationFormModel: txProcessCubit.msgFormModel,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          validatorWalletAddress: widget.validatorWalletAddress,
        );
      },
    );
  }
}
