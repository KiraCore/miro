import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/a_filters_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';

class FiltersActiveState<T extends AListItem> extends AFiltersState<T> {
  final FilterComparator<T> filterComparator;

  const FiltersActiveState({
    required List<FilterOption<T>> activeFilters,
    required this.filterComparator,
  }) : super(activeFilters: activeFilters);

  @override
  List<Object?> get props => <Object>[
        activeFilters,
        filterComparator,
      ];
}
