import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/transactions/transaction_drawer_page.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class TransactionListItemDesktop extends StatelessWidget {
  static const double height = 64;

  final TxListItemModel txListItemModel;

  const TransactionListItemDesktop({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TokenAmountModel? totalAmount = txListItemModel.txMsgModels.totalAmount;
    Set<String> fromAddresses =
        txListItemModel.txMsgModels.where((ATxMsgModel e) => e.fromAddress != null).map((ATxMsgModel e) => e.fromAddress!.bech32Address).toSet();
    Set<String> toAddresses =
        txListItemModel.txMsgModels.where((ATxMsgModel e) => e.toAddress != null).map((ATxMsgModel e) => e.toAddress!.bech32Address).toSet();
    // TODO(Mykyta): avoid direction type after INTERX updated to getAllTransactions
    List<String> methods = txListItemModel.txMsgModels.map((ATxMsgModel e) => e.getTitle(context, TxDirectionType.outbound)).toList();

    return InkWrapper(
      onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
        TransactionDrawerPage(txListItemModel: txListItemModel),
      ),
      child: TransactionListItemDesktopLayout(
        height: height,
        hashWidget: KiraToolTip(
          childMargin: EdgeInsets.zero,
          message: txListItemModel.hash,
          child: Text(
            CryptoAddressParser.stripHexPrefix(txListItemModel.hash),
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
          ),
        ),
        methodWidget: KiraToolTip(
          childMargin: EdgeInsets.zero,
          message: methods.join('\n\n'),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  methods.first,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                ),
              ),
              if (methods.length > 1) _RoundedCount(count: methods.length - 1),
            ],
          ),
        ),
        dateWidget: Text(
          DateFormat('d/M/y, HH:mm').format(txListItemModel.time.toLocal()),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
        ),
        fromWidget: txListItemModel.txMsgModels.isEmpty || txListItemModel.txMsgModels.first.fromAddress == null
            ? const Text('---')
            : KiraToolTip(
                childMargin: EdgeInsets.zero,
                message: fromAddresses.join('\n\n'),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        fromAddresses.first,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                      ),
                    ),
                    if (fromAddresses.length > 1) _RoundedCount(count: fromAddresses.length - 1),
                  ],
                ),
              ),
        toWidget: txListItemModel.txMsgModels.isEmpty || txListItemModel.txMsgModels.first.toAddress == null
            ? const Text('---')
            : KiraToolTip(
                childMargin: EdgeInsets.zero,
                message: toAddresses.join('\n\n'),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        toAddresses.first,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                      ),
                    ),
                    if (toAddresses.length > 1) _RoundedCount(count: toAddresses.length - 1),
                  ],
                ),
              ),
        amountWidget: txListItemModel.txMsgModels.isEmpty || totalAmount == null
            ? const Text('---')
            : Text(
                totalAmount.toString(),
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
              ),
        feeWidget: Text(
          txListItemModel.fees.reduce((TokenAmountModel count, TokenAmountModel e) => count + e).toString(),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
        ),
      ),
    );
  }
}

class _RoundedCount extends StatelessWidget {
  const _RoundedCount({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   border: Border.all(color: DesignColors.white2, width: 1),
      // ),
      padding: const EdgeInsets.only(left: 4),
      // padding: const EdgeInsets.only(left: 2, right: 3, top: 2, bottom: 2),
      child: Text(
        '+$count',
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodySmall!.copyWith(color: DesignColors.white2),
      ),
    );
  }
}
