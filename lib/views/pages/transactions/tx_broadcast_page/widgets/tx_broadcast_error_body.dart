import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/tx_broadcast_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/error_explorer_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/views/pages/transactions/tx_broadcast_page/widgets/tx_broadcast_status_icon.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/error_explorer_dialog/error_explorer_dialog.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class TxBroadcastErrorBody extends StatelessWidget {
  final String? txFormPageName;
  final SignedTxModel signedTxModel;
  final ErrorExplorerModel errorExplorerModel;

  const TxBroadcastErrorBody({
    required this.txFormPageName,
    required this.signedTxModel,
    required this.errorExplorerModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const TxBroadcastStatusIcon(status: false, size: 57),
        const SizedBox(height: 30),
        Text(
          S.of(context).txErrorFailed,
          textAlign: TextAlign.center,
          style: textTheme.headline3!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '<${errorExplorerModel.code}>',
              style: textTheme.caption!.copyWith(
                color: DesignColors.white1,
              ),
            ),
            const SizedBox(width: 8),
            TextLink(
              textStyle: textTheme.caption!.copyWith(
                color: DesignColors.white1,
              ),
              onTap: () => _showErrorExplorerDialog(context),
              text: S.of(context).txErrorSeeMore,
            ),
          ],
        ),
        const SizedBox(height: 42),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            KiraOutlinedButton(
              height: 51,
              width: 163,
              onPressed: () => _pressBackButton(context),
              title: S.of(context).txButtonBackToAccount,
            ),
            const SizedBox(height: 8),
            KiraOutlinedButton(
              height: 51,
              width: 163,
              onPressed: () => _pressEditTransactionButton(context),
              title: S.of(context).txButtonEditTransaction,
            ),
            const SizedBox(height: 8),
            KiraOutlinedButton(
              height: 51,
              width: 163,
              onPressed: () => _pressTryAgainButton(context),
              title: S.of(context).txTryAgain,
            ),
          ],
        ),
      ],
    );
  }

  void _showErrorExplorerDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => ErrorExplorerDialog(
        errorExplorerModel: errorExplorerModel,
      ),
    );
  }

  void _pressBackButton(BuildContext context) {
    KiraRouter.of(context).parent?.pop();
  }

  void _pressTryAgainButton(BuildContext context) {
    BlocProvider.of<TxBroadcastCubit>(context).broadcast(signedTxModel);
  }

  void _pressEditTransactionButton(BuildContext context) {
    if (txFormPageName == null) {
      return;
    }
    KiraRouter.of(context).popUntilRouteWithName(txFormPageName!);
  }
}
