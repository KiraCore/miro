import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/views/pages/dialog/widgets/json_preview.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class UndefinedTransactionPreview extends StatelessWidget {
  /// [SignedTransaction] or [UnsignedTransaction]
  final dynamic transaction;
  final TxMsg message;
  final TxFee fee;

  const UndefinedTransactionPreview({
    required this.transaction,
    required this.message,
    required this.fee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              AppIcons.eye_hidden,
              color: DesignColors.gray2_100,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'No transaction preview available',
                style: TextStyle(
                  color: DesignColors.gray2_100,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (transaction is SignedTransaction)
          JsonPreview(
            value: (transaction as SignedTransaction).toJson(),
          ),
        if (transaction is UnsignedTransaction)
          JsonPreview(
            value: (transaction as UnsignedTransaction).toJson(),
          ),
        const SizedBox(height: 20),
        PrefixedWidget(
          prefix: 'Transaction type',
          child: Text(message.runtimeType.toString()),
        ),
        const SizedBox(height: 20),
        PrefixedWidget(
          prefix: 'Transaction fee',
          child: Text(fee.amount.single.toString()),
        )
      ],
    );
  }
}
