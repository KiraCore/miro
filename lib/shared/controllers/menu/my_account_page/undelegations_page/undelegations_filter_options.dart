import 'package:intl/intl.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';

class UndelegationsFilterOptions {
  static FilterComparator<UndelegationModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (UndelegationModel item) {
      bool addressMatchBool = item.validatorSimplifiedModel.walletAddress.bech32Address.toLowerCase().contains(pattern);
      bool usernameMatchBool = item.validatorSimplifiedModel.moniker?.toLowerCase().contains(pattern) ?? false;
      bool tokensMatchBool = item.tokens.map((TokenAmountModel e) => e.toString()).join(' ').toLowerCase().contains(pattern);
      bool shortDateMatchBool = DateFormat('d MMM y, HH:mm').format(item.lockedUntil.toLocal()).toLowerCase().contains(pattern);
      bool longDateMatchBool = DateFormat('d MMMM y, HH:mm').format(item.lockedUntil.toLocal()).toLowerCase().contains(pattern);
      return addressMatchBool | usernameMatchBool | tokensMatchBool | shortDateMatchBool | longDateMatchBool;
    };
  }
}
