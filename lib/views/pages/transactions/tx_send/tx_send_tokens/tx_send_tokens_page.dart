import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_confirm_dialog.dart';
import 'package:miro/views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_form_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

class TxSendTokensPage extends StatefulWidget {
  final BalanceModel? defaultBalanceModel;

  const TxSendTokensPage({
    this.defaultBalanceModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendTokensPage();
}

class _TxSendTokensPage extends State<TxSendTokensPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<MsgSendFormModel> txProcessCubit = TxProcessCubit<MsgSendFormModel>(
    txMsgType: TxMsgType.msgSend,
    msgFormModel: MsgSendFormModel(
      balanceModel: widget.defaultBalanceModel,
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
    return TxProcessWrapper<MsgSendFormModel>(
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: (TxProcessLoadedState txProcessLoadedState) {
        return TxSendTokensFormDialog(
          feeTokenAmountModel: txProcessLoadedState.feeTokenAmountModel,
          onTxFormCompleted: txProcessCubit.submitTransactionForm,
          msgSendFormModel: txProcessCubit.msgFormModel,
        );
      },
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return TxSendTokensConfirmDialog(
          msgSendFormModel: txProcessCubit.msgFormModel,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
        );
      },
    );
  }
}
