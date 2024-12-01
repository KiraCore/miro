import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
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

  const TransactionListItemMobile({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TokenAmountModel? totalAmount = txListItemModel.txMsgModels.totalAmount;
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
          DateFormat('d MMM y, HH:mm').format(txListItemModel.time.toLocal()),
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
        ),
      ),
      if (txListItemModel.txMsgModels.isNotEmpty && txListItemModel.txMsgModels.first.fromAddress != null)
        PrefixedWidget(
          prefix: S.of(context).txListFrom,
          child: Row(
            children: <Widget>[
              CopyButton(
                value: txListItemModel.txMsgModels.first.fromAddress!.bech32Address,
                notificationText: S.of(context).toastSuccessfullyCopied,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: KiraToolTip(
                  childMargin: EdgeInsets.zero,
                  message: txListItemModel.txMsgModels.first.fromAddress!.bech32Address,
                  child: Text(
                    txListItemModel.txMsgModels.first.fromAddress!.bech32Address,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
                  ),
                ),
              ),
            ],
          ),
        ),
      if (txListItemModel.txMsgModels.isNotEmpty && txListItemModel.txMsgModels.first.toAddress != null)
        PrefixedWidget(
          prefix: S.of(context).txListTo,
          child: Row(
            children: <Widget>[
              CopyButton(
                value: txListItemModel.txMsgModels.first.toAddress!.bech32Address,
                notificationText: S.of(context).toastSuccessfullyCopied,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: KiraToolTip(
                  childMargin: EdgeInsets.zero,
                  message: txListItemModel.txMsgModels.first.toAddress!.bech32Address,
                  child: Text(
                    txListItemModel.txMsgModels.first.toAddress!.bech32Address,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
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
            Text(
              txListItemModel.getTitle(context),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
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
