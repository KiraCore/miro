import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/states/tx_form_builder_downloading_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/a_msg_form_controller.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_completing_indicator.dart';
import 'package:miro/views/pages/transactions/tx_form_page/send/widgets/tx_send_form_next_button.dart';

class TxSendFormFooter extends StatefulWidget {
  final String txFormPageName;
  final TokenAmountModel feeTokenAmountModel;
  final AMsgFormController msgFormController;
  final TokenDenominationModel? tokenDenominationModel;

  const TxSendFormFooter({
    required this.txFormPageName,
    required this.feeTokenAmountModel,
    required this.msgFormController,
    this.tokenDenominationModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendFormFooter();
}

class _TxSendFormFooter extends State<TxSendFormFooter> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxFormBuilderCubit txFormBuilderCubit = TxFormBuilderCubit(
    feeTokenAmountModel: widget.feeTokenAmountModel,
    msgFormController: widget.msgFormController,
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TxFormBuilderCubit, ATxFormBuilderState>(
      bloc: txFormBuilderCubit,
      builder: (BuildContext context, ATxFormBuilderState txFormBuilderState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (txFormBuilderState is TxFormBuilderDownloadingState)
              TxSendFormCompletingIndicator()
            else
              ValueListenableBuilder<bool>(
                valueListenable: widget.msgFormController.formFilledNotifier,
                builder: (_, bool formFilledBool, __) {
                  return TxSendFormNextButton(
                    hasError: txFormBuilderState is TxFormBuilderErrorState,
                    disabled: formFilledBool == false,
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
                  S.of(context).txNoticeFee(widget.feeTokenAmountModel.toString()),
                  style: textTheme.caption!.copyWith(
                    color: DesignColors.white1,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleNextButtonPressed(BuildContext context) async {
    try {
      UnsignedTxModel unsignedTxModel = await txFormBuilderCubit.buildUnsignedTx();
      await _navigateToNextPage(unsignedTxModel);
    } catch (e) {
      AppLogger().log(message: e.toString());
      return;
    }
  }

  Future<void> _navigateToNextPage(UnsignedTxModel unsignedTxModel) async {
    Wallet? wallet = authCubit.state;
    if (wallet != null) {
      SignedTxModel signedTxModel = TxUtils.sign(unsignedTxModel: unsignedTxModel, wallet: wallet);
      await KiraRouter.of(context).navigate(TxConfirmRoute(
        signedTxModel: signedTxModel,
        tokenDenominationModel: widget.tokenDenominationModel,
        txFormPageName: widget.txFormPageName,
      ));
    }
  }
}
