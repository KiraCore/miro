import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/tx_send_form_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/msg_send/msg_send_form.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/msg_send/msg_send_form_controller.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_cubit_wrapper.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_footer.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class TxTokensSendFormPage extends StatefulWidget {
  final BalanceModel? initialBalanceModel;

  const TxTokensSendFormPage({
    this.initialBalanceModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxTokensSendFormPage();
}

class _TxTokensSendFormPage extends State<TxTokensSendFormPage> {
  final TxSendFormCubit txSendFormCubit = TxSendFormCubit();
  final WalletProvider walletProvider = globalLocator<WalletProvider>();
  final MsgSendFormController msgSendFormController = MsgSendFormController();

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: 'Send tokens',
      child: TxSendFormCubitWrapper(
        txSendFormCubit: txSendFormCubit,
        childBuilder: (TxSendFormLoadedState txSendFormLoadedState) {
          return Column(
            children: <Widget>[
              MsgSendForm(
                feeTokenAmountModel: txSendFormLoadedState.feeTokenAmountModel,
                msgSendFormController: msgSendFormController,
                initialBalanceModel: widget.initialBalanceModel,
                initialWalletAddress: walletProvider.currentWallet?.address,
              ),
              const SizedBox(height: 30),
              TxSendFormFooter(
                txSendFormCubit: txSendFormCubit,
                feeTokenAmountModel: txSendFormLoadedState.feeTokenAmountModel,
                msgFormController: msgSendFormController,
              ),
            ],
          );
        },
      ),
    );
  }
}
