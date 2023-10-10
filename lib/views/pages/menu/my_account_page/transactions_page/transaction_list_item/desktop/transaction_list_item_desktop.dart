import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/tx_amount_text.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_status_chip/transaction_status_chip.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class TransactionListItemDesktop extends StatelessWidget {
  final TxListItemModel txListItemModel;

  const TransactionListItemDesktop({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return TransactionListItemDesktopLayout(
      height: 80,
      txWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 30,
            child: Center(
              child: IconTheme(
                data: const IconThemeData(
                  size: 28,
                  color: DesignColors.white1,
                ),
                child: txListItemModel.icon,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: PrefixedWidget(
              prefix: txListItemModel.getTitle(context),
              child: txListItemModel.getSubtitle(context) != null
                  ? Text(
                      txListItemModel.getSubtitle(context)!,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!.copyWith(
                        color: DesignColors.white2,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
      hashWidget: Row(
        children: <Widget>[
          CopyButton(
            value: txListItemModel.hash,
            notificationText: S.of(context).toastHashCopied,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              txListItemModel.hash,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(
                color: DesignColors.white2,
              ),
            ),
          ),
        ],
      ),
      statusWidget: TransactionStatusChip(txStatusType: txListItemModel.txStatusType),
      dateWidget: Text(
        DateFormat('d MMM y, HH:mm').format(txListItemModel.time.toLocal()),
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      amountWidget: TxAmountText(
        txListItemModel: txListItemModel,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );
  }
}
