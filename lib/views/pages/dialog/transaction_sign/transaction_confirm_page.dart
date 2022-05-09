import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/dialog/widgets/dialog_card.dart';
import 'package:miro/views/pages/dialog/widgets/message_previews/message_preview.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class TransactionConfirmPage extends StatelessWidget {
  final SignedTransaction signedTransaction;

  const TransactionConfirmPage({
    required this.signedTransaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DialogCard(
        title: 'Confirm transaction',
        trailingWidth: 68,
        trailingHeight: 39,
        trailing: KiraOutlinedButton(
          width: 68,
          height: 39,
          onPressed: () {},
          title: 'Edit',
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MessagePreview(
              transaction: signedTransaction,
              fee: signedTransaction.authInfo.fee,
              memo: signedTransaction.body.memo,
              message: signedTransaction.body.messages.single,
            ),
            const SizedBox(height: 40),
            KiraElevatedButton(
              width: 140,
              height: 51,
              onPressed: () {
                AutoRouter.of(context).push(TransactionBroadcastRoute(
                  signedTransaction: signedTransaction,
                ));
              },
              title: 'Confirm & Send',
            ),
          ],
        ),
      ),
    );
  }
}
