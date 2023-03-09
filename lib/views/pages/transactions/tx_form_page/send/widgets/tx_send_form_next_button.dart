import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:provider/provider.dart';

class TxSendFormNextButton extends StatelessWidget {
  final bool disabled;
  final bool hasError;
  final VoidCallback onPressed;

  const TxSendFormNextButton({
    required this.disabled,
    required this.hasError,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Consumer<WalletProvider>(
          builder: (_, WalletProvider walletProvider, __) {
            return KiraElevatedButton(
              disabled: disabled,
              title: 'Next',
              width: 82,
              onPressed: onPressed,
            );
          },
        ),
        const SizedBox(height: 8),
        if (hasError)
          Text(
            'Cannot create transaction. Check your connection',
            style: textTheme.caption!.copyWith(
              color: DesignColors.redStatus1,
            ),
          )
      ],
    );
  }
}
