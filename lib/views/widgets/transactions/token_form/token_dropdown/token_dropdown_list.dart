import 'package:flutter/material.dart';
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
  TokenAliasModel? selectedTokenAliasModel;

  @override
  void initState() {
    super.initState();
    selectedTokenAliasModel = widget.initialTokenAliasModel;
  }

  @override
  Widget build(BuildContext context) {
    return PopupInfinityList<BalanceModel>(
      defaultSortOption: BalancesSortOptions.sortByDenom,
      itemBuilder: (BalanceModel balanceModel) {
        TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
        return TokenDropdownListItem(
          tokenAliasModel: tokenAliasModel,
          selected: selectedTokenAliasModel == tokenAliasModel,
          onTap: () => _handleItemSelected(balanceModel),
          favourite: balanceModel.isFavourite,
        );
      },
      listController: BalancesListController(address: widget.walletAddress?.bech32Address ?? ''),
      searchComparator: BalancesFilterOptions.search,
      singlePageSize: 20,
      searchBarTitle: S.of(context).txSearchTokens,
    );
  }

  void _handleItemSelected(BalanceModel balanceModel) {
    selectedTokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
    widget.onBalanceModelSelected.call(balanceModel);
    setState(() {});
  }
}
