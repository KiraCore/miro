import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';

class TxDialogError<T extends AMsgFormModel> extends StatelessWidget {
  const TxDialogError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            S.of(context).txErrorCannotFetchDetails,
            textAlign: TextAlign.center,
            style: textTheme.bodyText2!.copyWith(
              color: DesignColors.redStatus1,
            ),
          ),
          const SizedBox(height: 20),
          TextButton.icon(
            onPressed: BlocProvider.of<TxProcessCubit<T>>(context).init,
            icon: const Icon(
              AppIcons.refresh,
              size: 18,
            ),
            label: Text(
              S.of(context).txTryAgain,
              style: textTheme.subtitle2!.copyWith(
                color: DesignColors.white1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
