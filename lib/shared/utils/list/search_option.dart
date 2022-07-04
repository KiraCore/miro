import 'package:miro/shared/utils/list/filter_mode.dart';
import 'package:miro/shared/utils/list/filter_option.dart';

class SearchOption<T> extends FilterOption<T> {
  const SearchOption(FilterComparator<T> comparator)
      : super(
          id: 'search',
          comparator: comparator,
          filterMode: FilterMode.and,
        );
}
