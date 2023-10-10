import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TxDialogLoading extends StatelessWidget {
  const TxDialogLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CenterLoadSpinner(),
          const SizedBox(height: 20),
          Text(
            S.of(context).txFetchingRemoteData,
            style: textTheme.bodyLarge!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ],
      ),
    );
  }
}
