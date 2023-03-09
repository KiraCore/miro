import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:provider/provider.dart';

class TxSendFormCompletingIndicator extends StatelessWidget {
  const TxSendFormCompletingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CenterLoadSpinner(size: 12),
        const SizedBox(width: 10),
        Consumer<WalletProvider>(
          builder: (BuildContext context, WalletProvider walletProvider, _) {
            return Text(
              'Signing transaction',
              style: textTheme.caption!.copyWith(
                color: DesignColors.white1,
              ),
            );
          },
        ),
      ],
    );
  }
}
