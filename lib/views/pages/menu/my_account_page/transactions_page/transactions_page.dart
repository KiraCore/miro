import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/transaction_list_item_builder.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/page_size_dropdown/page_size_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list.dart';

class TransactionsPage extends StatefulWidget {
  final String address;
  final ScrollController parentScrollController;

  const TransactionsPage({
    required this.address,
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  _TransactionsPage createState() => _TransactionsPage();
}

class _TransactionsPage extends State<TransactionsPage> {
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerTextStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    Widget listHeaderWidget = TransactionListItemDesktopLayout(
      height: 53,
      txWidget: Text(S.of(context).txListDetails, style: headerTextStyle),
      hashWidget: Text(S.of(context).txListHash, style: headerTextStyle),
      statusWidget: Text(S.of(context).txListStatus, style: headerTextStyle),
      dateWidget: Text(S.of(context).txListDate, style: headerTextStyle),
      amountWidget: Text(S.of(context).txListAmount, style: headerTextStyle),
    );

    return SliverPaginatedList<TxListItemModel>(
      scrollController: widget.parentScrollController,
      hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
      singlePageSize: pageSize,
      listController: TransactionsListController(address: widget.address),
      listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
      title: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            PageSizeDropdown(
              selectedPageSize: pageSize,
              availablePageSizes: const <int>[10, 25, 50, 100],
              onPageSizeChanged: (int pageSize) {
                setState(() => this.pageSize = pageSize);
              },
            ),
          ],
        ),
      ),
      itemBuilder: (TxListItemModel txListItemModel) {
        return TransactionListItemBuilder(
          txListItemModel: txListItemModel,
        );
      },
    );
  }
}
