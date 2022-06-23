import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class SignTransactionButton extends StatefulWidget {
  final MsgFormController<TxMsg> msgFormController;
  final Future<void> Function() onPressed;

  const SignTransactionButton({
    required this.msgFormController,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignTransactionButton();
}

class _SignTransactionButton extends State<SignTransactionButton> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox(
        height: 51,
        child: Center(
          child: Text('Signing transaction...'),
        ),
      );
    }

    return ValueListenableBuilder<String?>(
      valueListenable: widget.msgFormController.errorMessageNotifier,
      builder: (_, String? errorMessage, __) {
        Widget buttonWidget = KiraElevatedButton(
          width: 82,
          height: 51,
          disabled: errorMessage != null,
          onPressed: () => _onSignTransactionButtonPressed(context),
          title: 'Next',
        );

        if (errorMessage != null) {
          return KiraToolTip(
            childMargin: EdgeInsets.zero,
            message: errorMessage ?? '',
            child: buttonWidget,
          );
        }
        return buttonWidget;
      },
    );
  }

  Future<void> _onSignTransactionButtonPressed(BuildContext context) async {
    _setLoadingStatus(status: true);
    await widget.onPressed();
    _setLoadingStatus(status: false);
  }

  void _setLoadingStatus({required bool status}) {
    setState(() {
      loading = status;
    });
  }
}
