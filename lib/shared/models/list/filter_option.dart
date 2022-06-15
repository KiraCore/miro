import 'package:equatable/equatable.dart';

typedef FilterComparator<T> = bool Function(T item);

class FilterOption<T> extends Equatable {
  final String id;
  final FilterComparator<T> comparator;
  final bool force;

  const FilterOption({
    required this.id,
    required this.comparator,
    this.force = false,
  });

  FilterOption<T> copyWith({
    String? id,
    FilterComparator<T>? comparator,
    bool? force,
  }) {
    return FilterOption<T>(
      id: id ?? this.id,
      comparator: comparator ?? this.comparator,
      force: force ?? this.force,
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
