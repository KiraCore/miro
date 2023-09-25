import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/popup_infinity_list/popup_infinity_list.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_list_item.dart';

class TokenDropdownList extends StatefulWidget {
  final TokenAliasModel? initialTokenAliasModel;
  final ValueChanged<BalanceModel> onBalanceModelSelected;
  final WalletAddress? walletAddress;

  const TokenDropdownList({
    required this.initialTokenAliasModel,
    required this.onBalanceModelSelected,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenDropdownList();
}

class _TokenDropdownList extends State<TokenDropdownList> {
  final SortBloc<BalanceModel> sortBloc = SortBloc<BalanceModel>(
    defaultSortOption: BalancesSortOptions.sortByDenom,
  );
  final FiltersBloc<BalanceModel> filtersBloc = FiltersBloc<BalanceModel>(
    searchComparator: BalancesFilterOptions.search,
  );

  late final BalancesListController balancesListController = BalancesListController(address: widget.walletAddress?.bech32Address ?? '');
  late final FavouritesBloc<BalanceModel> favouritesBloc = FavouritesBloc<BalanceModel>(
    listController: balancesListController,
  );

  TokenAliasModel? selectedTokenAliasModel;

  @override
  void initState() {
    super.initState();
    selectedTokenAliasModel = widget.initialTokenAliasModel;
  }

  @override
  void dispose() {
    sortBloc.close();
    filtersBloc.close();
    favouritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupInfinityList<BalanceModel>(
      itemBuilder: (BalanceModel balanceModel) {
        TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
        return TokenDropdownListItem(
          tokenAliasModel: tokenAliasModel,
          selected: selectedTokenAliasModel == tokenAliasModel,
          onTap: () => _handleItemSelected(balanceModel),
          favourite: balanceModel.isFavourite,
        );
      },
      listController: balancesListController,
      singlePageSize: 20,
      searchBarTitle: S.of(context).txSearchTokens,
      sortBloc: sortBloc,
      filtersBloc: filtersBloc,
      favouritesBloc: favouritesBloc,
    );
  }

  void _handleItemSelected(BalanceModel balanceModel) {
    selectedTokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
    widget.onBalanceModelSelected.call(balanceModel);
    setState(() {});
  }
}
