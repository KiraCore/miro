import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsFilterOptions {
  static FilterOption<ValidatorModel> filterByActiveValidators = FilterOption<ValidatorModel>(
    id: 'active',
    comparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.active,
  );

  static FilterOption<ValidatorModel> filterByInactiveValidators = FilterOption<ValidatorModel>(
    id: 'inactive',
    comparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.inactive,
  );

  static FilterOption<ValidatorModel> filterByJailedValidators = FilterOption<ValidatorModel>(
    id: 'jailed',
    comparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.jailed,
  );

  static FilterOption<ValidatorModel> filterByPausedValidators = FilterOption<ValidatorModel>(
    id: 'paused',
    comparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.paused,
  );

  static FilterOption<ValidatorModel> filterByWaitingValidators = FilterOption<ValidatorModel>(
    id: 'waiting',
    comparator: (ValidatorModel a) => a.validatorStatus == ValidatorStatus.waiting,
  );

  static FilterComparator<ValidatorModel> search(String searchText) {
    return (ValidatorModel item) {
      bool monikerMatch = item.moniker.toLowerCase().contains(searchText.toLowerCase());
      bool topMatch = item.top.toString().contains(searchText);
      return monikerMatch || topMatch;
    };
  }
}
