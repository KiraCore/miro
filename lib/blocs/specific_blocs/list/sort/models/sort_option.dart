import 'package:equatable/equatable.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_mode.dart';

class SortOption<T extends AListItem> extends Equatable {
  final String id;
  final Comparator<T> comparator;
  final SortMode sortMode;

  const SortOption.asc({
    required this.id,
    required this.comparator,
  }) : sortMode = SortMode.asc;

  const SortOption.desc({
    required this.id,
    required this.comparator,
  }) : sortMode = SortMode.desc;

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
    return sortMode == SortMode.asc;
  }

  bool get descending {
    return sortMode == SortMode.desc;
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
}
