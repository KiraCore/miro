import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/utils/pages/list_items_comparator.dart';
import 'package:miro/shared/utils/string_utils.dart';

enum BalanceSortOption {
  name,
  amount,
}

enum BalanceFilterOption {
  smallBalances,
}

class BalancesComparator extends ListItemsComparator<BalanceFilterOption, BalanceSortOption, Balance> {
  @override
  Map<BalanceSortOption, SortOption<Balance>> sortOptions = const <BalanceSortOption, SortOption<Balance>>{
    BalanceSortOption.name: SortOption<Balance>(
      name: 'Name',
      comparator: _sortByName,
    ),
    BalanceSortOption.amount: SortOption<Balance>(
      name: 'Amount',
      comparator: _sortByAmount,
    ),
  };

  @override
  Map<BalanceFilterOption, FilterOption<Balance>> filterOptions = const <BalanceFilterOption, FilterOption<Balance>>{
    BalanceFilterOption.smallBalances: FilterOption<Balance>(
      name: 'Hide small balances',
      comparator: _filterSmallBalances,
    ),
  };

  static int _sortByAmount(Balance a, Balance b) {
    try {
      return double.tryParse(a.amount)!.compareTo(double.tryParse(b.amount)!);
    } catch (_) {
      return 0;
    }
  }

  static int _sortByName(Balance a, Balance b) {
    try {
      return a.denom.toLowerCase().compareTo(b.denom.toLowerCase());
    } catch (_) {
      return 0;
    }
  }

  static bool _filterSmallBalances(Balance item) {
    return (double.tryParse(item.amount) ?? 0) > 1;
  }

  static bool filterSearch(Balance item, String searchValue) {
    bool searchDenomStatus = StringUtils.compareStrings(item.denom, searchValue);
    bool searchAmountStatus = StringUtils.compareStrings(item.amount, searchValue);
    return searchAmountStatus || searchDenomStatus;
  }
}
