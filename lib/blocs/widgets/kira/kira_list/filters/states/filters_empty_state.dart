import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/a_filters_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';

class FiltersEmptyState<T extends AListItem> extends AFiltersState<T> {
  FiltersEmptyState() : super(activeFilters: List<FilterOption<T>>.empty(growable: true));
}
