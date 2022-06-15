import 'package:miro/shared/models/list/filter_option.dart';

class SearchOption<T> extends FilterOption<T> {
  const SearchOption(FilterComparator<T> comparator)
      : super(
          id: 'search',
          comparator: comparator,
          force: true,
        );
}
