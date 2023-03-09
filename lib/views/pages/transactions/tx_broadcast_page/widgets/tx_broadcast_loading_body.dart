import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/states/tx_broadcast_loading_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';

class TxBroadcastLoadingBody extends StatelessWidget {
  final TxBroadcastLoadingState txBroadcastLoadingState;

  const TxBroadcastLoadingBody({
    required this.txBroadcastLoadingState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          Assets.assetsLogoLoading,
          height: 61,
          width: 61,
        ),
        const SizedBox(height: 30),
        Text(
          'Your transaction is being broadcast',
          textAlign: TextAlign.center,
          style: textTheme.headline3!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Do not close this window',
          textAlign: TextAlign.center,
          style: textTheme.caption!.copyWith(
            color: DesignColors.white2,
          ),
        ),
      ],
    );
  }
}
