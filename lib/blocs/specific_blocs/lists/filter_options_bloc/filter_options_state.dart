import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/filter_option.dart';

abstract class FilterOptionsState<T> extends Equatable {
  final List<FilterOption<T>> activeFilters;

  const FilterOptionsState({
    required this.activeFilters,
  });

  @override
  List<Object?> get props => <Object>[];
}

class EmptyFiltersState<T> extends FilterOptionsState<T> {
  EmptyFiltersState() : super(activeFilters: List<FilterOption<T>>.empty());
}

class FiltersActiveState<T> extends FilterOptionsState<T> {
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
