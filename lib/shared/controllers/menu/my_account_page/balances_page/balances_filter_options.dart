import 'package:decimal/decimal.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_mode.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/shared/models/balances/balance_model.dart';

Decimal kSmallValue = Decimal.parse('1');

class BalancesFilterOptions {
  static FilterOption<BalanceModel> filterBySmallValues = FilterOption<BalanceModel>(
    id: 'small',
    filterComparator: (BalanceModel a) => a.tokenAmountModel.getAmountInDefaultDenomination() > kSmallValue,
    filterMode: FilterMode.and,
  );

  static FilterComparator<BalanceModel> search(String searchText) {
    return (BalanceModel item) {
      bool amountDefaultMatch = item.tokenAmountModel.getAmountInDefaultDenomination().toString().contains(searchText);
      bool amountLowestMatch = item.tokenAmountModel.getAmountInLowestDenomination().toString().contains(searchText);
      bool amountMatch = amountDefaultMatch || amountLowestMatch;

      bool denomDefaultMatch = item.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name.toLowerCase().contains(searchText);
      bool denomLowestMatch = item.tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name.toLowerCase().contains(searchText);
      bool denomMatch = denomDefaultMatch || denomLowestMatch;

      bool nameMatch = item.tokenAmountModel.tokenAliasModel.name.toLowerCase().contains(searchText);
      return amountMatch || denomMatch || nameMatch;
    };
  }
}
