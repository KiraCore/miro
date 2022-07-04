import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/sort_option.dart';

class SortOptionEvent extends Equatable {
  const SortOptionEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ChangeSortOptionEvent<T> extends SortOptionEvent {
  final SortOption<T> sortOption;

  const ChangeSortOptionEvent({
    required this.sortOption,
  });

  @override
  List<Object?> get props => <Object?>[sortOption.hashCode];
}

class ClearSortOptionEvent<T> extends SortOptionEvent {
  const ClearSortOptionEvent();
}
