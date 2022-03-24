import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/list/sorting_status.dart';

typedef FilterComparator<T> = bool Function(T item);

class FilterOption<T> extends Equatable {
  final String name;
  final FilterComparator<T> comparator;
  final SortingStatus sortingStatus;

  const FilterOption({
    required this.name,
    required this.comparator,
    this.sortingStatus = SortingStatus.asc,
  });

  FilterOption<T> copyWith({
    String? name,
    FilterComparator<T>? comparator,
    SortingStatus? sortingStatus,
  }) {
    return FilterOption<T>(
      name: name ?? this.name,
      comparator: comparator ?? this.comparator,
      sortingStatus: sortingStatus ?? this.sortingStatus,
    );
  }

  @override
  List<Object?> get props => <Object>[name];

  @override
  String toString() {
    return 'SortOption{name: $name, comparator: $comparator, sortingStatus: $sortingStatus}';
  }
}
