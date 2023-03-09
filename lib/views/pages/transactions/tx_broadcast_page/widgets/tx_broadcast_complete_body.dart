import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_completed_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_status_icon.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';

class TxBroadcastCompleteBody extends StatelessWidget {
  final TxBroadcastCompletedState txBroadcastCompletedState;

  const TxBroadcastCompleteBody({
    required this.txBroadcastCompletedState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const TxBroadcastStatusIcon(status: true, size: 57),
        const SizedBox(height: 30),
        Text(
          'Transaction completed',
          textAlign: TextAlign.center,
          style: textTheme.headline3!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 12),
        CopyWrapper(
          value: '0x${txBroadcastCompletedState.broadcastRespModel.hash}',
          notificationText: 'Transaction hash copied to clipboard',
          child: Text(
            'Transaction hash: 0x${txBroadcastCompletedState.broadcastRespModel.hash}',
            textAlign: TextAlign.center,
            style: textTheme.caption!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ),
        const SizedBox(height: 42),
        KiraOutlinedButton(
          height: 51,
          width: 163,
          onPressed: () => _handleBackPressed(context),
          title: 'Back to account',
        ),
      ],
    );
  }

  void _handleBackPressed(BuildContext context) {
    KiraRouter.of(context).parent?.pop();
  }
}
