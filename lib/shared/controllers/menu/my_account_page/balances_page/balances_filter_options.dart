import 'package:decimal/decimal.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_mode.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/balances/balance_model.dart';

class BalancesFilterOptions {
  static final Decimal _smallValueLimit = Decimal.fromInt(1);

  static FilterOption<BalanceModel> filterBySmallValues = FilterOption<BalanceModel>(
    id: 'small',
    filterComparator: (BalanceModel a) => a.tokenAmountModel.getAmountInNetworkDenomination() > _smallValueLimit,
    filterMode: FilterMode.and,
  );

  static FilterOption<BalanceModel> filterByDefaultToken = FilterOption<BalanceModel>(
    id: 'defaultToken',
    filterComparator: (BalanceModel a) =>
        a.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel ==
        globalLocator<NetworkModuleBloc>().state.defaultTokenAliasModel!.defaultTokenDenominationModel,
    filterMode: FilterMode.and,
  );

  static FilterComparator<BalanceModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (BalanceModel item) {
      bool amountNetworkMatch = item.tokenAmountModel.getAmountInNetworkDenomination().toString().contains(pattern);
      bool amountDefaultMatch = item.tokenAmountModel.getAmountInDefaultDenomination().toString().contains(pattern);
      bool amountMatch = amountNetworkMatch || amountDefaultMatch;

      bool denomNetworkMatch = item.tokenAmountModel.tokenAliasModel.networkTokenDenominationModel.name.toLowerCase().contains(pattern);
      bool denomDefaultMatch = item.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name.toLowerCase().contains(pattern);
      bool denomMatch = denomNetworkMatch || denomDefaultMatch;

      bool nameMatch = item.tokenAmountModel.tokenAliasModel.name.toLowerCase().contains(pattern);
      return amountMatch || denomMatch || nameMatch;
    };
  }
}
