import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_title/balance_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

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
    double listHeight = MediaQuery.of(context).size.height - 470;
    double itemSize = const ResponsiveValue<double>(largeScreen: 70, smallScreen: 180).get(context);

    return SliverInfinityList<BalanceModel>(
      defaultSortOption: BalancesSortOptions.sortByDenom,
      itemBuilder: (BalanceModel balanceModel) => BalanceListItemBuilder(
        key: Key('${balanceModel.hashCode}'),
        balanceModel: balanceModel,
        scrollController: parentScrollController,
      ),
      listController: BalancesListController(address: address),
      searchComparator: BalancesFilterOptions.search,
      scrollController: parentScrollController,
      singlePageSize: listHeight ~/ itemSize + 5,
      title: const BalanceListTitle(),
      reloadNotifierModel: globalLocator<ReloadNotifierController>().myAccountBalanceListNotifier,
    );
  }
}
