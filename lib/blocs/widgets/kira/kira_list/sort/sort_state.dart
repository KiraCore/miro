import 'package:equatable/equatable.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';

class SortState<T extends AListItem> extends Equatable {
  final SortOption<T> activeSortOption;

  const SortState(this.activeSortOption);

  @override
  List<Object?> get props => <Object?>[activeSortOption.id, activeSortOption.sortMode];
}
