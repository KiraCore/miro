import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';

class ValidatorsFilterOptions {
  static FilterOption<ValidatorModel> filterByActiveValidators = FilterOption<ValidatorModel>(
    id: 'active',
    filterComparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.active,
  );

  static FilterOption<ValidatorModel> filterByInactiveValidators = FilterOption<ValidatorModel>(
    id: 'inactive',
    filterComparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.inactive,
  );

  static FilterOption<ValidatorModel> filterByJailedValidators = FilterOption<ValidatorModel>(
    id: 'jailed',
    filterComparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.jailed,
  );

  static FilterOption<ValidatorModel> filterByPausedValidators = FilterOption<ValidatorModel>(
    id: 'paused',
    filterComparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.paused,
  );

  static FilterComparator<ValidatorModel> search(String searchText) {
    String pattern = searchText.toLowerCase();

    return (ValidatorModel item) {
      bool monikerMatch = item.moniker.toLowerCase().contains(pattern);
      bool topMatch = item.top.toString().contains(pattern);
      return monikerMatch || topMatch;
    };
  }
}
