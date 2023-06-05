import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/a_tx_form_builder_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_downloading_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/states/tx_form_builder_error_state.dart';
import 'package:miro/blocs/pages/transactions/tx_form_builder/tx_form_builder_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
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
  late final TxFormBuilderCubit txFormBuilderCubit = TxFormBuilderCubit(
    feeTokenAmountModel: widget.feeTokenAmountModel,
    msgFormModel: widget.msgFormModel,
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
    if (widget.formKey.currentState!.validate() == false) {
      AppLogger().log(message: 'Form is not valid');
      return;
    }
    try {
      UnsignedTxModel unsignedTxModel = await txFormBuilderCubit.buildUnsignedTx();
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
    SignedTxModel signedTxModel = TxUtils.sign(unsignedTxModel: unsignedTxModel, wallet: wallet);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return signedTxModel;
  }
}
