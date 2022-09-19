import 'package:flutter/material.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/views/widgets/transactions/tx_dialog.dart';

class TxConfirmPage extends StatelessWidget {
  final SignedTxModel signedTxModel;

  const TxConfirmPage({
    required this.signedTxModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TxDialog(
      title: 'Confirm transaction',
      child: Text(signedTxModel.toString()),
    );
  }
}
