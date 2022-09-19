import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/a_tx_send_form_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_init_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/tx_send_form_cubit.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TxSendFormCubitWrapper extends StatefulWidget {
  final Widget Function(TxSendFormLoadedState createTxLoadedState) childBuilder;
  final TxSendFormCubit txSendFormCubit;

  const TxSendFormCubitWrapper({
    required this.childBuilder,
    required this.txSendFormCubit,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TxSendFormCubitWrapper();
}

class _TxSendFormCubitWrapper extends State<TxSendFormCubitWrapper> {
  @override
  void initState() {
    super.initState();
    widget.txSendFormCubit.loadTxFee();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TxSendFormCubit, ATxSendFormState>(
      bloc: widget.txSendFormCubit,
      builder: (BuildContext context, ATxSendFormState txSendFormState) {
        if (txSendFormState is TxSendFormInitState) {
          return SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CenterLoadSpinner(),
                const SizedBox(height: 20),
                Text(
                  'Fetching remote data. Please wait...',
                  style: textTheme.bodyText1!.copyWith(
                    color: DesignColors.white_100,
                  ),
                ),
              ],
            ),
          );
        } else if (txSendFormState is TxSendFormErrorState) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cannot fetch transaction details. Check your internet connection',
                  style: textTheme.caption!.copyWith(
                    color: DesignColors.red_100,
                  ),
                ),
                const SizedBox(height: 20),
                TextButton.icon(
                  onPressed: widget.txSendFormCubit.loadTxFee,
                  icon: const Icon(
                    AppIcons.refresh,
                    size: 18,
                  ),
                  label: Text(
                    'Try again',
                    style: textTheme.subtitle2!.copyWith(
                      color: DesignColors.white_100,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return widget.childBuilder(txSendFormState as TxSendFormLoadedState);
        }
      },
    );
  }
}
