import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class StakingFilterOptions {
  static FilterComparator<ValidatorStakingModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (ValidatorStakingModel item) {
      bool tokenMatchBool = item.tokens.map((TokenAliasModel e) => e.lowestTokenDenominationModel.name).join(' ').toLowerCase().contains(pattern);
      bool addressMatchBool = item.validatorSimplifiedModel.walletAddress.bech32Address.toLowerCase().contains(pattern);
      bool usernameMatchBool = item.validatorSimplifiedModel.moniker?.toLowerCase().contains(pattern) ?? false;
      bool websiteMatchBool = item.validatorSimplifiedModel.website?.toLowerCase().contains(pattern) ?? false;
      bool statusMatchBool = item.stakingPoolStatus.name.toLowerCase().contains(pattern);
      bool commissionMatchBool = item.commission.contains(pattern);
      return tokenMatchBool | addressMatchBool | usernameMatchBool | websiteMatchBool | statusMatchBool | commissionMatchBool;
    };
  }
}
