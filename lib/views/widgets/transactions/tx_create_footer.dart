import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/pages/transactions/a_tx_msg_form_controller.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';
import 'package:provider/provider.dart';

class TxCreateFooter extends StatelessWidget {
  final TokenAmountModel feeTokenAmountModel;
  final ATxMsgFormController txMsgFormController;

  const TxCreateFooter({
    required this.feeTokenAmountModel,
    required this.txMsgFormController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ValueListenableBuilder<bool>(
          valueListenable: txMsgFormController.formFilledNotifier,
          builder: (_, bool formFilled, __) {
            bool disabled = !formFilled;
            return Consumer<WalletProvider>(
              builder: (BuildContext context, WalletProvider walletProvider, _) {
                return KiraElevatedButton(
                  disabled: disabled,
                  title: 'Next',
                  width: 82,
                  onPressed: () => _handleNextButtonPressed(context),
                );
              },
            );
          },
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Transaction fee $feeTokenAmountModel',
              style: textTheme.caption!.copyWith(
                color: DesignColors.white_100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _handleNextButtonPressed(BuildContext context) {
    ITxMsgModel? txMsgModel = txMsgFormController.buildTxMsgModel();
    if (txMsgModel != null) {
      String memo = txMsgFormController.memo;
      TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
        feeTokenAmountModel: feeTokenAmountModel,
        memo: memo,
        txMsgModel: txMsgModel,
      );
      // TODO(dominik): Implement _handleNextButtonPressed
      print('SEND: ${txLocalInfoModel}');
    } else {
      AppLogger().log(message: 'Unexpected error. Cannot create form', logLevel: LogLevel.error);
      KiraToast.of(context).show(
        message: 'Form invalid',
        type: ToastType.error,
        toastDuration: const Duration(seconds: 5),
      );
    }
  }
}
