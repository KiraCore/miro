import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

class ValidatorsSortOptions {
  static SortOption<ValidatorModel> get sortByTop {
    return SortOption<ValidatorModel>.asc(
      id: 'top',
      comparator: (ValidatorModel a, ValidatorModel b) => a.top.compareTo(b.top),
    );
  }

  static SortOption<ValidatorModel> get sortByMoniker {
    return SortOption<ValidatorModel>.asc(
      id: 'moniker',
      comparator: (ValidatorModel a, ValidatorModel b) => a.moniker.compareTo(b.moniker),
    );
  }

  static SortOption<ValidatorModel> get sortByStatus {
    return SortOption<ValidatorModel>.asc(
      id: 'status',
      comparator: (ValidatorModel a, ValidatorModel b) =>
          a.validatorStatus.toString().compareTo(b.validatorStatus.toString()),
    );
  }
}
