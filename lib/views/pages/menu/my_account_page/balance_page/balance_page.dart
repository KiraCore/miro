import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/layout/footer/footer.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/small_balances_checkbox.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_infinity_list/kira_infinity_list.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class BalancePage extends StatelessWidget {
  final String address;
  final ScrollController parentScrollController;

  const BalancePage({
    required this.address,
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget sortDropdownWidget = SortDropdown<BalanceModel>(
      sortOptionModels: <SortOptionModel<BalanceModel>>[
        SortOptionModel<BalanceModel>(
          title: 'Name',
          sortOption: BalancesSortOptions.sortByDenom,
        ),
        SortOptionModel<BalanceModel>(
          title: 'Amount',
          sortOption: BalancesSortOptions.sortByAmount,
        ),
      ],
    );

    return Column(
      children: <Widget>[
        KiraInfinityList<BalanceModel>(
          reloadNotifierModel: globalLocator<ReloadNotifierController>().myAccountBalanceListNotifier,
          scrollController: parentScrollController,
          defaultSortOption: BalancesSortOptions.sortByDenom,
          searchComparator: BalancesFilterOptions.search,
          listController: BalancesListController(address: address),
          minHeight: MediaQuery.of(context).size.height - 490,
          itemBuilder: (BalanceModel balanceModel) {
            return BalanceListItemBuilder(
              key: Key(balanceModel.tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name),
              balanceModel: balanceModel,
              scrollController: parentScrollController,
            );
          },
          title: ResponsiveWidget(
            largeScreen: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    sortDropdownWidget,
                    const SizedBox(height: 5),
                    const LastBlockTimeWidget(),
                  ],
                ),
                const Spacer(),
                const SmallBalanceCheckbox(),
                const SizedBox(width: 32),
                const ListSearchWidget<BalanceModel>(
                  hint: 'Search balances',
                ),
              ],
            ),
            mediumScreen: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const LastBlockTimeWidget(),
                const SizedBox(height: 15),
                const ListSearchWidget<BalanceModel>(
                  width: double.infinity,
                  hint: 'Search balances',
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SmallBalanceCheckbox(),
                    sortDropdownWidget,
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        const Footer(),
      ],
    );
  }
}
