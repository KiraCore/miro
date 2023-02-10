import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/transactions/tx_confirm_page/form_previews/tx_confirm_form_preview.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class TxConfirmPage extends StatelessWidget {
  final String? txFormPageName;
  final SignedTxModel? signedTxModel;
  final TokenDenominationModel? tokenDenominationModel;

  const TxConfirmPage({
    @QueryParam('txFormPageName') this.txFormPageName,
    @QueryParam('tx') this.signedTxModel,
    @QueryParam('denom') this.tokenDenominationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (signedTxModel == null) {
      KiraRouter.of(context).navigateBack();
    }
    return TxDialog(
      suffixWidget: KiraOutlinedButton(
        width: 68,
        height: 39,
        title: 'Edit',
        onPressed: () => KiraRouter.of(context).navigateBack(),
      ),
      title: 'Confirm transaction',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TxConfirmFormPreview(
            txLocalInfoModel: signedTxModel!.txLocalInfoModel,
            tokenDenominationModel: tokenDenominationModel,
          ),
          const SizedBox(height: 30),
          KiraElevatedButton(
            width: 160,
            onPressed: () => KiraRouter.of(context).navigate(TxBroadcastRoute(signedTxModel: signedTxModel, txFormPageName: txFormPageName)),
            title: 'Confirm & send',
          ),
        ],
      ),
    );
  }
}
