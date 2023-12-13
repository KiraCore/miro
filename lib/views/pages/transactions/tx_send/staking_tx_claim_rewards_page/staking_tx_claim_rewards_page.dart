import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_rewards_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/staking_tx_claim_rewards_page/staking_tx_claim_rewards_confirm_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

@RoutePage()
class StakingTxClaimRewardsPage extends StatefulWidget {
  const StakingTxClaimRewardsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingTxClaimRewardsPage();
}

class _StakingTxClaimRewardsPage extends State<StakingTxClaimRewardsPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<StakingMsgClaimRewardsFormModel> txProcessCubit = TxProcessCubit<StakingMsgClaimRewardsFormModel>(
    txMsgType: TxMsgType.msgClaimRewards,
    msgFormModel: StakingMsgClaimRewardsFormModel(
      senderWalletAddress: authCubit.state?.address,
    ),
  );

  @override
  void dispose() {
    txProcessCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<StakingMsgClaimRewardsFormModel>(
      formEnabledBool: false,
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: null,
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return StakingTxClaimRewardsConfirmDialog(
          stakingMsgClaimRewardsFormModel: txProcessCubit.msgFormModel,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
        );
      },
    );
  }
}
