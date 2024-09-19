import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_title/balance_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

class BalancePage extends StatefulWidget {
  final WalletAddress walletAddress;
  final ScrollController parentScrollController;

  const BalancePage({
    required this.walletAddress,
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  _BalancePage createState() => _BalancePage();
}

class _BalancePage extends State<BalancePage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final SortBloc<BalanceModel> sortBloc = SortBloc<BalanceModel>(
    defaultSortOption: BalancesSortOptions.sortByDenom,
  );
  final FiltersBloc<BalanceModel> filtersBloc = FiltersBloc<BalanceModel>(
    searchComparator: BalancesFilterOptions.search,
  );

  late final BalancesListController balancesListController =
      BalancesListController(walletAddress: widget.walletAddress);
  late final FavouritesBloc<BalanceModel> favouritesBloc = FavouritesBloc<BalanceModel>(
    listController: balancesListController,
  );

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    sortBloc.close();
    filtersBloc.close();
    favouritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(Mykyta): send from specific address MetaMask
    double listHeight = MediaQuery.of(context).size.height - 470;
    double itemSize = const ResponsiveValue<double>(largeScreen: 70, smallScreen: 180).get(context);

    return SliverInfinityList<BalanceModel>(
      itemBuilder: (BalanceModel balanceModel) => BalanceListItemBuilder(
        sendButtonActiveBool: balanceModel.tokenAmountModel.getAmountInDefaultDenomination() != Decimal.zero,
        key: Key('${balanceModel.hashCode}'),
        balanceModel: balanceModel,
        scrollController: widget.parentScrollController,
      ),
      listController: balancesListController,
      scrollController: widget.parentScrollController,
      singlePageSize: listHeight ~/ itemSize + 5,
      title: BalanceListTitle(searchBarTextEditingController: searchBarTextEditingController),
      sortBloc: sortBloc,
      filtersBloc: filtersBloc,
      favouritesBloc: favouritesBloc,
    );
  }
}
