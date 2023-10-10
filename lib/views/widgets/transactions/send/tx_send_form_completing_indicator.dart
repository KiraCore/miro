import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TxSendFormCompletingIndicator extends StatelessWidget {
  const TxSendFormCompletingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CenterLoadSpinner(size: 12),
        const SizedBox(width: 10),
        Text(
          S.of(context).txSigning,
          style: textTheme.bodySmall!.copyWith(color: DesignColors.white1),
        ),
      ],
    );
  }
}
