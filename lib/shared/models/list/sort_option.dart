import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/list/sorting_status.dart';

class SortOption<T> extends Equatable {
  final String id;
  final Comparator<T> comparator;
  final SortingStatus _sortingStatus;

  const SortOption.asc({
    required this.id,
    required this.comparator,
  }) : _sortingStatus = SortingStatus.asc;

  const SortOption.desc({
    required this.id,
    required this.comparator,
  }) : _sortingStatus = SortingStatus.desc;

  SortOption<T> reversed() {
    if (ascending) {
      return SortOption<T>.desc(
        id: id,
        comparator: comparator,
      );
    } else {
      return SortOption<T>.asc(
        id: id,
        comparator: comparator,
      );
    }
  }

  bool get ascending {
    return _sortingStatus == SortingStatus.asc;
  }

  bool get descending {
    return _sortingStatus == SortingStatus.desc;
  }

  List<T> sort(List<T> list) {
    if (ascending) {
      return list..sort(comparator);
    } else {
      return list..sort((T a, T b) => comparator(b, a));
    }
  }

  @override
  List<Object?> get props => <Object>[id];

  @override
  String toString() {
    return 'SortOption{id: $id, comparator: $comparator, sortingStatus: $_sortingStatus}';
  }
}
