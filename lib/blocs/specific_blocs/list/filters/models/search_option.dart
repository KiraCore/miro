import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_mode.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

class SearchOption<T extends AListItem> extends FilterOption<T> {
  const SearchOption(FilterComparator<T> comparator)
      : super(
          id: 'search',
          filterComparator: comparator,
          filterMode: FilterMode.and,
        );
}
