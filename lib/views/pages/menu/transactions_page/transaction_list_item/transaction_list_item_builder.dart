import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/mobile/transaction_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionListItemBuilder extends StatelessWidget {
  final TxListItemModel txListItemModel;
  final ScrollController scrollController;
  final bool isAgeFormatBool;

  const TransactionListItemBuilder({
    required this.txListItemModel,
    required this.scrollController,
    required this.isAgeFormatBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = TransactionListItemDesktop(txListItemModel: txListItemModel, isAgeFormatBool: isAgeFormatBool);
    Widget mobileListItem = TransactionListItemMobile(txListItemModel: txListItemModel, isAgeFormatBool: isAgeFormatBool);

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
