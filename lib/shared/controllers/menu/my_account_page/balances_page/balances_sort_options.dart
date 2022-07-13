import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/shared/models/balances/balance_model.dart';

class BalancesSortOptions {
  static SortOption<BalanceModel> get sortByDenom {
    return SortOption<BalanceModel>.asc(
      id: 'denom',
      comparator: (BalanceModel a, BalanceModel b) => a.tokenAmountModel.tokenAliasModel.name.compareTo(b.tokenAmountModel.tokenAliasModel.name),
    );
  }

  static SortOption<BalanceModel> get sortByAmount {
    return SortOption<BalanceModel>.asc(
      id: 'amount',
      comparator: (BalanceModel a, BalanceModel b) =>
          a.tokenAmountModel.getAmountInDefaultDenomination().compareTo(b.tokenAmountModel.getAmountInDefaultDenomination()),
    );
  }
}
