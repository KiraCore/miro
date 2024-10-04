import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_downloading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_completing_indicator.dart';
import 'package:miro/views/widgets/transactions/send/tx_send_form_next_button.dart';

class TxSendFormFooter extends StatefulWidget {
  final TokenAmountModel feeTokenAmountModel;
  final GlobalKey<FormState> formKey;
  final AMsgFormModel msgFormModel;
  final ValueChanged<SignedTxModel> onSubmit;

  const TxSendFormFooter({
    required this.feeTokenAmountModel,
    required this.formKey,
    required this.msgFormModel,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendFormFooter();
}

class _TxSendFormFooter extends State<TxSendFormFooter> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final MetamaskCubit metamaskCubit = globalLocator<MetamaskCubit>();
  late final TxFormBuilderCubit txFormBuilderCubit = TxFormBuilderCubit(
    feeTokenAmountModel: widget.feeTokenAmountModel,
    msgFormModel: widget.msgFormModel,
  );

  @override
  void dispose() {
    txFormBuilderCubit.close();
    super.dispose();
  }

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
              const TxSendFormCompletingIndicator()
            else
              AnimatedBuilder(
                animation: widget.msgFormModel,
                builder: (BuildContext context, Widget? _) {
                  bool formFilledBool = widget.msgFormModel.canBuildTxMsg();
                  return TxSendFormNextButton(
                    errorExistsBool: txFormBuilderState is TxFormBuilderErrorState,
                    disabledBool: formFilledBool == false,
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
                  style: textTheme.bodySmall!.copyWith(
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
    if (widget.formKey.currentState!.validate() == false) {
      AppLogger().log(message: 'Form is not valid');
      return;
    }
    try {
      UnsignedTxModel unsignedTxModel = await txFormBuilderCubit.buildUnsignedTx();
      if (metamaskCubit.isSupported && authCubit.state!.ecPrivateKey == null) {
        // TODO(Mykyta): is there possibility that model can be not a MsgSendModel ? (`send-via-metamask` task)
        // ignore:unused_local_variable
        int amount = (unsignedTxModel.txLocalInfoModel.txMsgModel as MsgSendModel).tokenAmountModel.getAmountInDefaultDenomination().toBigInt().toInt();
        // TODO(Mykyta): add error handling at `send-via-metamask` task
        await metamaskCubit.pay(
          to: authCubit.state!.address,
          amount: 0,
        );
        return;
      }
      SignedTxModel signedTxModel = await _signTransaction(unsignedTxModel);
      widget.onSubmit(signedTxModel);
    } catch (e) {
      AppLogger().log(message: e.toString());
      return;
    }
  }

  Future<SignedTxModel> _signTransaction(UnsignedTxModel unsignedTxModel) async {
    Wallet? wallet = authCubit.state;
    if (wallet == null) {
      throw Exception('Wallet cannot be null when signing transaction');
    }
    SignedTxModel signedTxModel = unsignedTxModel.sign(wallet);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return signedTxModel;
  }
}
