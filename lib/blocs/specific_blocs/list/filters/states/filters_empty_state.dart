import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

class FiltersEmptyState<T extends AListItem> extends AFiltersState<T> {
  FiltersEmptyState() : super(activeFilters: List<FilterOption<T>>.empty(growable: true));
}
