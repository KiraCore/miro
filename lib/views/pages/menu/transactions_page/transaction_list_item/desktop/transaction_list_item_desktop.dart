import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/transactions/transaction_drawer_page.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
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

    return TransactionListItemDesktopLayout(
      height: height,
      hashWidget: InkWell(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
          TransactionDrawerPage(txListItemModel: txListItemModel),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  style: textTheme.bodyMedium!.copyWith(color: DesignColors.hyperlink),
                ),
              ),
            ),
          ],
        ),
      ),
      methodWidget: Text(
        txListItemModel.getTitle(context),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
      ),
      dateWidget: Text(
        DateFormat('d/M/y, HH:mm').format(txListItemModel.time.toLocal()),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyLarge!.copyWith(color: DesignColors.white2),
      ),
      fromWidget: txListItemModel.txMsgModels.isEmpty || txListItemModel.txMsgModels.first.fromAddress == null
          ? const Text('---')
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                  ),
                ),
              ],
            ),
      toWidget: txListItemModel.txMsgModels.isEmpty || txListItemModel.txMsgModels.first.toAddress == null
          ? const Text('---')
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      style: textTheme.bodyMedium!.copyWith(color: DesignColors.white2),
                    ),
                  ),
                ),
              ],
            ),
      amountWidget: txListItemModel.txMsgModels.isEmpty
          ? const Text('')
          : totalAmount == null
              ? InkWell(
                  onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(
                    TransactionDrawerPage(txListItemModel: txListItemModel),
                  ),
                  child: Text(
                    S.of(context).more,
                    style: textTheme.bodyLarge!.copyWith(color: DesignColors.hyperlink),
                  ),
                )
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
      // favouriteButtonWidget: StarButton(
      //   key: Key('fav_transaction_${txListItemModel.moniker}'),
      //   onChanged: onFavouriteButtonPressed,
      //   size: 20,
      //   value: txListItemModel.isFavourite,
      // ),
    );
  }
}
