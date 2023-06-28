import 'package:decimal/decimal.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_mode.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/balances/balance_model.dart';

class BalancesFilterOptions {
  static final Decimal _smallValueLimit = Decimal.fromInt(1);

  static FilterOption<BalanceModel> filterBySmallValues = FilterOption<BalanceModel>(
    id: 'small',
    filterComparator: (BalanceModel a) => a.tokenAmountModel.getAmountInDefaultDenomination() > _smallValueLimit,
    filterMode: FilterMode.and,
  );

  static FilterComparator<BalanceModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (BalanceModel item) {
      bool amountDefaultMatch = item.tokenAmountModel.getAmountInDefaultDenomination().toString().contains(pattern);
      bool amountLowestMatch = item.tokenAmountModel.getAmountInLowestDenomination().toString().contains(pattern);
      bool amountMatch = amountDefaultMatch || amountLowestMatch;

      bool denomDefaultMatch = item.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name.toLowerCase().contains(pattern);
      bool denomLowestMatch = item.tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name.toLowerCase().contains(pattern);
      bool denomMatch = denomDefaultMatch || denomLowestMatch;

      bool nameMatch = item.tokenAmountModel.tokenAliasModel.name.toLowerCase().contains(pattern);
      return amountMatch || denomMatch || nameMatch;
    };
  }
}
