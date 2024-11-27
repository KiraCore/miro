import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/transactions/transaction_drawer_page.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class TransactionListItemMobile extends StatelessWidget {
  final TxListItemModel txListItemModel;
  final bool isAgeFormatBool;

  const TransactionListItemMobile({
    required this.txListItemModel,
    required this.isAgeFormatBool,
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
    if (methods.length > methods.toSet().length) {
      for (final String method in methods.toSet()) {
        int count = methods.where((String element) => element == method).length;
        if (count > 1) {
          methods[methods.indexOf(method)] = '$method x$count';
          methods.removeWhere((String element) => element == method);
        }
      }
    }

    List<Widget> children = <Widget>[
      PrefixedWidget(
        prefix: S.of(context).txnListHash,
        child: Row(
          children: <Widget>[
            CopyButton(
              value: txListItemModel.hash,
              notificationText: S.of(context).toastSuccessfullyCopied,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: KiraToolTip(
                childMargin: EdgeInsets.zero,
                message: txListItemModel.hash,
                child: Text(
                  CryptoAddressParser.stripHexPrefix(txListItemModel.hash),
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                ),
              ),
            ),
          ],
        ),
      ),
      PrefixedWidget(
        prefix: S.of(context).txListDate,
        child: Text(
          DateFormat('d MMM y, HH:mm:ss').format(txListItemModel.time.toLocal()),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
        ),
      ),
      if (fromAddresses.isNotEmpty)
        PrefixedWidget(
          prefix: S.of(context).txListFrom,
          child: Row(
            children: <Widget>[
              CopyButton(
                value: fromAddresses.first,
                notificationText: S.of(context).toastSuccessfullyCopied,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: KiraToolTip(
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
                      if (fromAddresses.length > 1) _Count(count: fromAddresses.length - 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      if (toAddresses.isNotEmpty)
        PrefixedWidget(
          prefix: S.of(context).txListTo,
          child: Row(
            children: <Widget>[
              CopyButton(
                value: toAddresses.first,
                notificationText: S.of(context).toastSuccessfullyCopied,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: KiraToolTip(
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
                      if (toAddresses.length > 1) _Count(count: toAddresses.length - 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      if (txListItemModel.txMsgModels.isNotEmpty && totalAmount != null)
        PrefixedWidget(
          prefix: S.of(context).txListAmount,
          child: Text(
            totalAmount.toString(),
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
          ),
        ),
      PrefixedWidget(
        prefix: S.of(context).txnListFee,
        child: Text(
          txListItemModel.fees.reduce((TokenAmountModel count, TokenAmountModel e) => count + e).toString(),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWrapper(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
          TransactionDrawerPage(txListItemModel: txListItemModel),
        ),
        padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 26),
        borderRadius: BorderRadius.circular(8),
        backgroundColor: DesignColors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            KiraToolTip(
              childMargin: EdgeInsets.zero,
              message: methods.join('\n\n'),
              child: Text(
                methods.join(', '),
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
              ),
            ),
            const SizedBox(height: 4),
            const Divider(color: DesignColors.grey2),
            const SizedBox(height: 4),
            for (int i = 0; i < children.length; i += 2) ...<Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: children[i]),
                  const SizedBox(width: 16),
                  if (i + 1 == children.length) const Spacer() else Expanded(child: children[i + 1]),
                ],
              ),
              if (i + 2 < children.length) const SizedBox(height: 18),
            ],
          ],
        ),
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        '+$count',
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodySmall!.copyWith(color: DesignColors.white2),
      ),
    );
  }
}
