import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/tx_amount_text.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_status_chip/transaction_status_chip.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class TransactionListItemMobile extends StatelessWidget {
  final TxListItemModel txListItemModel;

  const TransactionListItemMobile({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          Row(
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
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: PrefixedWidget(
                        prefix: S.of(context).txListHash,
                        child: Text(
                          txListItemModel.hash,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium!.copyWith(
                            color: DesignColors.white2,
                          ),
                        ),
                      ),
                    ),
                    CopyButton(
                      value: txListItemModel.hash,
                      notificationText: S.of(context).toastHashCopied,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).txListStatus,
                  child: TransactionStatusChip(txStatusType: txListItemModel.txStatusType),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).txListDate,
                  child: Text(
                    DateFormat('d MMM y, HH:mm').format(txListItemModel.time.toLocal()),
                    style: textTheme.bodyMedium!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).txListAmount,
                  child: TxAmountText(
                    txListItemModel: txListItemModel,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
