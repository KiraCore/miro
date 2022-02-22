import 'package:equatable/equatable.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sorting_status.dart';

class SortOption<T> extends Equatable {
  final String name;
  final Comparator<T> comparator;
  final SortingStatus sortingStatus;

  const SortOption({
    required this.name,
    required this.comparator,
    this.sortingStatus = SortingStatus.asc,
  });

  SortOption<T> copyWith({
    String? name,
    Comparator<T>? comparator,
    SortingStatus? sortingStatus,
  }) {
    return SortOption<T>(
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
