import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class TxSendFormNextButton extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  final bool disabledBool;
  final bool errorExistsBool;
  final VoidCallback onPressed;

  TxSendFormNextButton({
    required this.disabledBool,
    required this.errorExistsBool,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        KiraElevatedButton(
          disabled: disabledBool,
          title: S.of(context).txButtonNext,
          width: 82,
          onPressed: onPressed,
        ),
        const SizedBox(height: 8),
        if (errorExistsBool)
          Text(
            S.of(context).txErrorCannotCreate,
            style: textTheme.caption!.copyWith(color: DesignColors.redStatus1),
          )
      ],
    );
  }
}
