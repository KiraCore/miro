import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/my_transactions_page/my_transaction_list_item/desktop/my_transaction_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/my_transactions_page/my_transaction_list_item/mobile/my_transaction_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class MyTransactionListItemBuilder extends StatelessWidget {
  final TxListItemModel txListItemModel;

  const MyTransactionListItemBuilder({
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget desktopWidget = MyTransactionListItemDesktop(txListItemModel: txListItemModel);
    Widget mobileWidget = MyTransactionListItemMobile(txListItemModel: txListItemModel);

    return ResponsiveWidget(
      largeScreen: desktopWidget,
      mediumScreen: mobileWidget,
      smallScreen: mobileWidget,
    );
  }
}
