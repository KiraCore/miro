import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class TxSendFormNextButton extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final bool disabled;
  final bool hasError;
  final VoidCallback onPressed;

  TxSendFormNextButton({
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
        BlocBuilder<AuthCubit, Wallet?>(
          bloc: authCubit,
          builder: (_, Wallet? wallet) {
            return KiraElevatedButton(
              disabled: disabled,
              title: S.of(context).txButtonNext,
              width: 82,
              onPressed: onPressed,
            );
          },
        ),
        const SizedBox(height: 8),
        if (hasError)
          Text(
            S.of(context).txErrorCannotCreate,
            style: textTheme.caption!.copyWith(
              color: DesignColors.redStatus1,
            ),
          )
      ],
    );
  }
}
