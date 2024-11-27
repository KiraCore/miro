import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/transactions/transactions_page/transactions_page_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_filter_options.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/desktop/transaction_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_item/transaction_list_item_builder.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_title/transaction_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list.dart';

@RoutePage()
class TransactionsPage extends StatefulWidget {
  const TransactionsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsPage();
}

class _TransactionsPage extends State<TransactionsPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final TransactionsListController transactionsListController = TransactionsListController();
  final FiltersBloc<TxListItemModel> filtersBloc = FiltersBloc<TxListItemModel>(
    searchComparator: TransactionsFilterOptions.search,
  );
  int pageSize = 15;

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    scrollController.dispose();
    filtersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return BlocProvider<TransactionsPageCubit>(
      create: (BuildContext context) => TransactionsPageCubit(),
      child: BlocBuilder<TransactionsPageCubit, TransactionsPageState>(
        builder: (BuildContext context, TransactionsPageState state) {
          Widget listHeaderWidget = TransactionListItemDesktopLayout(
            height: 64,
            hashWidget: Text(S.of(context).txnListHash, style: headerStyle),
            methodWidget: Text(S.of(context).txListMethod, style: headerStyle),
            dateWidget: InkWell(
              onTap: () => context.read<TransactionsPageCubit>().switchDateFormat(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  state.isAgeFormatBool ? S.of(context).txListAge : S.of(context).txListDate,
                  style: headerStyle.copyWith(color: DesignColors.hyperlink),
                ),
              ),
            ),
            isDateInAgeFormatBool: state.isAgeFormatBool,
            fromWidget: Text(S.of(context).txListFrom, style: headerStyle),
            toWidget: Text(S.of(context).txListTo, style: headerStyle),
            amountWidget: Text(S.of(context).txListAmount, style: headerStyle),
            feeWidget: Text(S.of(context).txnListFee, style: headerStyle),
          );

          return CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverPadding(
                padding: AppSizes.getPagePadding(context),
                sliver: SliverPaginatedList<TxListItemModel>(
                  desktopItemHeight: 80,
                  listController: transactionsListController,
                  scrollController: scrollController,
                  singlePageSize: pageSize,
                  hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
                  listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
                  filtersBloc: filtersBloc,
                  titleBuilder: (BuildContext context) {
                    return TransactionListTitle(
                      searchBarTextEditingController: searchBarTextEditingController,
                      transactionsListController: transactionsListController,
                    );
                  },
                  itemBuilder: (TxListItemModel txListItemModel) => TransactionListItemBuilder(
                    key: Key(txListItemModel.toString()),
                    txListItemModel: txListItemModel,
                    scrollController: scrollController,
                    isAgeFormatBool: state.isAgeFormatBool,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
