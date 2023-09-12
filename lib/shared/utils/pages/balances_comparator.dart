import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/shared/utils/string_utils.dart';

class BalancesComparator {
  static int sortByAmount(Balance a, Balance b) {
    try {
      return double.tryParse(a.amount)!.compareTo(double.tryParse(b.amount)!);
    } catch (_) {
      return 0;
    }
  }

  static int sortByName(Balance a, Balance b) {
    try {
      return a.denom.toLowerCase().compareTo(b.denom.toLowerCase());
    } catch (_) {
      return 0;
    }
  }

  static bool filterSmallBalances(Balance item) {
    return (double.tryParse(item.amount) ?? 0) > 1;
  }

  static bool clear(Balance _) {
    return true;
  }

  static bool filterSearch(Balance item, String searchValue) {
    bool searchDenomStatus = StringUtils.hasPatternsAfterUnified(item.denom, searchValue);
    bool searchAmountStatus = StringUtils.hasPatternsAfterUnified(item.amount, searchValue);
    return searchAmountStatus || searchDenomStatus;
  }
}
