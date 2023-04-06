import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class TxSendFormCompletingIndicator extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  TxSendFormCompletingIndicator({
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
        BlocBuilder<AuthCubit, Wallet?>(
          bloc: authCubit,
          builder: (BuildContext context, Wallet? wallet) {
            return Text(
              S.of(context).txSigning,
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
