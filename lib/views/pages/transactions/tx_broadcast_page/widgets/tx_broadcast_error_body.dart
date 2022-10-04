import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_error_state.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_status_icon.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class TxBroadcastErrorBody extends StatelessWidget {
  final SignedTxModel signedTxModel;
  final TxBroadcastErrorState txBroadcastErrorState;

  const TxBroadcastErrorBody({
    required this.signedTxModel,
    required this.txBroadcastErrorState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const TxBroadcastStatusIcon(status: false, size: 57),
        const SizedBox(height: 30),
        Text(
          'Transaction failed',
          textAlign: TextAlign.center,
          style: textTheme.headline3!.copyWith(
            color: DesignColors.white_100,
          ),
        ),
        const SizedBox(height: 42),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            KiraOutlinedButton(
              height: 51,
              width: 163,
              onPressed: () => _handleBackPressed(context),
              title: 'Back to account',
            ),
            const SizedBox(width: 8),
            KiraOutlinedButton(
              height: 51,
              width: 121,
              onPressed: () => _handleTryAgainPressed(context),
              title: 'Try again',
            ),
          ],
        )
      ],
    );
  }

  void _handleBackPressed(BuildContext context) {
    AutoRouter.of(context).root.pop();
  }

  void _handleTryAgainPressed(BuildContext context) {
    BlocProvider.of<TxBroadcastCubit>(context).broadcast(signedTxModel);
  }
}
