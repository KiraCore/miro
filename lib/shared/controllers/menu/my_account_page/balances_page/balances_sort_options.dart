import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
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
          a.tokenAmountModel.getAmountInNetworkDenomination().compareTo(b.tokenAmountModel.getAmountInNetworkDenomination()),
    );
  }
}
