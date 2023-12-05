import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';

class UndelegationsSortOptions {
  static SortOption<UndelegationModel> get sortByDate {
    return SortOption<UndelegationModel>.asc(
      id: 'date',
      comparator: (UndelegationModel a, UndelegationModel b) => a.lockedUntil.compareTo(b.lockedUntil),
    );
  }
}
