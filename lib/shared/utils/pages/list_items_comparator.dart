import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';

abstract class ListItemsComparator<FilterComparatorType, SortComparatorType, ItemType> {
  Map<SortComparatorType, SortOption<ItemType>> get sortOptions;

  Map<FilterComparatorType, FilterOption<ItemType>> get filterOptions;

  SortOption<ItemType> getSortOption(SortComparatorType option) {
    return sortOptions[option]!;
  }

  List<SortOption<ItemType>> getAllSortOptions() {
    return sortOptions.values.toList();
  }

  FilterOption<ItemType> getFilterOption(FilterComparatorType option) {
    return filterOptions[option]!;
  }

  List<FilterOption<ItemType>> getAllFilterOptions() {
    return filterOptions.values.toList();
  }
}
