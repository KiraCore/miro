import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/filter_mode.dart';

typedef FilterComparator<T> = bool Function(T item);

class FilterOption<T> extends Equatable {
  final String id;
  final FilterComparator<T> comparator;
  final FilterMode filterMode;

  const FilterOption({
    required this.id,
    required this.comparator,
    this.filterMode = FilterMode.or,
  });

  FilterOption<T> copyWith({
    String? id,
    FilterComparator<T>? comparator,
    FilterMode? filterMode,
  }) {
    return FilterOption<T>(
      id: id ?? this.id,
      comparator: comparator ?? this.comparator,
      filterMode: filterMode ?? this.filterMode,
    );
  }

  bool hasMatch(T item) {
    return comparator(item);
  }

  @override
  List<Object?> get props => <Object>[id];

  @override
  String toString() {
    return 'FilterOption{id: $id, comparator: $comparator}';
  }
}
