import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/mobile/transaction_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionListItemBuilder extends StatelessWidget {
  final TxListItemModel txListItemModel;

  const TransactionListItemBuilder({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget desktopWidget = TransactionListItemDesktop(txListItemModel: txListItemModel);
    Widget mobileWidget = TransactionListItemMobile(txListItemModel: txListItemModel);

    return ResponsiveWidget(
      largeScreen: desktopWidget,
      mediumScreen: mobileWidget,
      smallScreen: mobileWidget,
    );
  }
}
