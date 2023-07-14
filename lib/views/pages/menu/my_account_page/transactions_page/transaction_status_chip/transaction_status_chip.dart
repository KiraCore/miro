import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_status_chip/transaction_status_chip_model.dart';

class TransactionStatusChip extends StatelessWidget {
  final TxStatusType txStatusType;

  const TransactionStatusChip({
    required this.txStatusType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TransactionStatusChipModel transactionStatusChipModel = _getTransactionStatusChipModel(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: transactionStatusChipModel.color.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          transactionStatusChipModel.title,
          style: textTheme.caption!.copyWith(
            color: transactionStatusChipModel.color,
          ),
        ),
      ),
    );
  }

  TransactionStatusChipModel _getTransactionStatusChipModel(BuildContext context) {
    switch (txStatusType) {
      case TxStatusType.confirmed:
        return TransactionStatusChipModel(color: DesignColors.greenStatus1, title: S.of(context).txListStatusConfirmed);
      case TxStatusType.pending:
        return TransactionStatusChipModel(color: DesignColors.yellowStatus1, title: S.of(context).txListStatusPending);
      case TxStatusType.failed:
        return TransactionStatusChipModel(color: DesignColors.redStatus1, title: S.of(context).txListStatusFailed);
    }
  }
}
