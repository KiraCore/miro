import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/tx_send/staking_tx_delegate_page/staking_tx_delegate_confirm_dialog.dart';
import 'package:miro/views/pages/transactions/tx_send/staking_tx_delegate_page/staking_tx_delegate_form_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

@RoutePage()
class StakingTxDelegatePage extends StatefulWidget {
  final List<TokenAliasModel> stakeableTokens;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const StakingTxDelegatePage({
    required this.stakeableTokens,
    required this.validatorSimplifiedModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingTxDelegatePage();
}

class _StakingTxDelegatePage extends State<StakingTxDelegatePage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<StakingMsgDelegateFormModel> txProcessCubit = TxProcessCubit<StakingMsgDelegateFormModel>(
    txMsgType: TxMsgType.msgDelegate,
    msgFormModel: StakingMsgDelegateFormModel(
      delegatorWalletAddress: authCubit.state?.address,
      valoperWalletAddress: WalletAddress(addressBytes: widget.validatorSimplifiedModel.walletAddress.addressBytes, bech32Hrp: 'kiravaloper'),
      tokenAliasModel: globalLocator<AppConfig>().defaultFeeTokenAliasModel,
    ),
  );

  @override
  void dispose() {
    txProcessCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<StakingMsgDelegateFormModel>(
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: (TxProcessLoadedState txProcessLoadedState) {
        return StakingTxDelegateFormDialog(
          stakingMsgDelegateFormModel: txProcessCubit.msgFormModel,
          feeTokenAmountModel: txProcessLoadedState.feeTokenAmountModel,
          onTxFormCompleted: txProcessCubit.submitTransactionForm,
          initialFilterComparator: _compareAllowedTokens,
          validatorSimplifiedModel: widget.validatorSimplifiedModel,
        );
      },
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return StakingTxDelegateConfirmDialog(
          moniker: widget.validatorSimplifiedModel.moniker.toString(),
          stakingMsgDelegateFormModel: txProcessCubit.msgFormModel,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          validatorWalletAddress: widget.validatorSimplifiedModel.walletAddress,
        );
      },
    );
  }

  bool _compareAllowedTokens(BalanceModel balanceModel) {
    return widget.stakeableTokens.contains(balanceModel.tokenAmountModel.tokenAliasModel);
  }
}
