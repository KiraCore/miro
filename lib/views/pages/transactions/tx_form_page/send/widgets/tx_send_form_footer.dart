import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_building_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_building_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/tx_send_form_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/tx_signer.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/a_msg_form_controller.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_completing_indicator.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_next_button.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class TxSendFormFooter extends StatefulWidget {
  final TxSendFormCubit txSendFormCubit;
  final TokenAmountModel feeTokenAmountModel;
  final AMsgFormController msgFormController;

  const TxSendFormFooter({
    required this.txSendFormCubit,
    required this.feeTokenAmountModel,
    required this.msgFormController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendFormFooter();
}

class _TxSendFormFooter extends State<TxSendFormFooter> {
  final WalletProvider walletProvider = globalLocator<WalletProvider>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.txSendFormCubit.state is TxSendFormBuildingState)
          const TxSendFormCompletingIndicator()
        else
          ValueListenableBuilder<bool>(
            valueListenable: widget.msgFormController.formFilledNotifier,
            builder: (_, bool formFilled, __) {
              return TxSendFormNextButton(
                hasError: widget.txSendFormCubit.state is TxSendFormBuildingErrorState,
                disabled: formFilled == false,
                onPressed: () => _handleNextButtonPressed(context),
              );
            },
          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Transaction fee ${widget.feeTokenAmountModel}',
              style: textTheme.caption!.copyWith(
                color: DesignColors.gray2_100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleNextButtonPressed(BuildContext context) async {
    UnsignedTxModel? unsignedTxModel = await _buildUnsignedTx();
    if (unsignedTxModel == null) {
      AppLogger().log(message: 'Form should be valid to call _handleNextButtonPressed', logLevel: LogLevel.error);
      return;
    }

    Wallet? wallet = walletProvider.currentWallet;
    if (wallet != null) {
      SignedTxModel signedTxModel = TxSigner.sign(unsignedTxModel: unsignedTxModel, wallet: wallet);
      await AutoRouter.of(context).navigate(TxConfirmRoute(signedTxModel: signedTxModel));
    }
  }

  Future<UnsignedTxModel?> _buildUnsignedTx() async {
    ITxMsgModel? txMsgModel = _getTxMsgModel();
    if (txMsgModel == null) {
      AppLogger().log(message: 'Form should be valid to call _buildUnsignedTx', logLevel: LogLevel.error);
      return null;
    }
    String memo = widget.msgFormController.memo;
    TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
      feeTokenAmountModel: widget.feeTokenAmountModel,
      memo: memo,
      txMsgModel: txMsgModel,
    );
    UnsignedTxModel? unsignedTxModel = await widget.txSendFormCubit.buildTx(txLocalInfoModel);
    return unsignedTxModel;
  }

  ITxMsgModel? _getTxMsgModel() {
    ITxMsgModel? txMsgModel = widget.msgFormController.buildTxMsgModel();
    if (txMsgModel == null) {
      AppLogger().log(message: 'Unexpected error. Cannot create ITxMsgModel', logLevel: LogLevel.error);
      KiraToast.of(context).show(
        message: 'Form invalid',
        type: ToastType.error,
        toastDuration: const Duration(seconds: 5),
      );
    }
    return txMsgModel;
  }
}
