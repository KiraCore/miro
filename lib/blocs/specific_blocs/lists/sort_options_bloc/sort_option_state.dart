import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/sort_option.dart';

class SortOptionState<T> extends Equatable {
  final SortOption<T> activeSortOption;

  const SortOptionState(this.activeSortOption);

  @override
  List<Object?> get props => <Object?>[activeSortOption.hashCode];
}
