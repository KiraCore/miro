import 'package:equatable/equatable.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_mode.dart';

typedef FilterComparator<T> = bool Function(T item);

class FilterOption<T extends AListItem> extends Equatable {
  final String id;
  final FilterComparator<T> filterComparator;
  final FilterMode filterMode;

  const FilterOption({
    required this.id,
    required this.filterComparator,
    this.filterMode = FilterMode.or,
  });

  FilterOption<T> copyWith({
    String? id,
    FilterComparator<T>? filterComparator,
    FilterMode? filterMode,
  }) {
    return FilterOption<T>(
      id: id ?? this.id,
      filterComparator: filterComparator ?? this.filterComparator,
      filterMode: filterMode ?? this.filterMode,
    );
  }

  bool hasMatch(T item) {
    return filterComparator(item);
  }

  @override
  List<Object?> get props => <Object>[id];

  @override
  String toString() {
    return 'FilterOption{id: $id, comparator: $filterComparator}';
  }
}
