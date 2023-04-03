import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/states/tx_form_init_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/msg_send/msg_send_form.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/msg_send/msg_send_form_controller.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_form_init_cubit_wrapper.dart';
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
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final Key txFormInitCubitWrapperKey = UniqueKey();
  final MsgSendFormController msgSendFormController = MsgSendFormController();
  final ValueNotifier<TokenDenominationModel?> tokenDenominationModelNotifier = ValueNotifier<TokenDenominationModel?>(null);

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: 'Send tokens',
      child: TxFormInitCubitWrapper(
        key: txFormInitCubitWrapperKey,
        txMsgType: TxMsgType.msgSend,
        childBuilder: (TxFormInitLoadedState txFormInitLoadedState) {
          return Column(
            children: <Widget>[
              MsgSendForm(
                feeTokenAmountModel: txFormInitLoadedState.feeTokenAmountModel,
                msgSendFormController: msgSendFormController,
                initialBalanceModel: widget.initialBalanceModel,
                initialWalletAddress: authCubit.state?.address,
                onTokenDenominationChanged: _handleTokenDenominationChanged,
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder<TokenDenominationModel?>(
                valueListenable: tokenDenominationModelNotifier,
                builder: (_, TokenDenominationModel? tokenDenominationModel, __) {
                  return TxSendFormFooter(
                    txFormPageName: TxTokensSendFormRoute.name,
                    feeTokenAmountModel: txFormInitLoadedState.feeTokenAmountModel,
                    msgFormController: msgSendFormController,
                    tokenDenominationModel: tokenDenominationModel,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleTokenDenominationChanged(TokenDenominationModel? tokenDenominationModel) {
    tokenDenominationModelNotifier.value = tokenDenominationModel;
  }
}
