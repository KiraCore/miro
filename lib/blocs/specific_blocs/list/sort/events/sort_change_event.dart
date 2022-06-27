import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/a_sort_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';

class SortChangeEvent<T extends AListItem> extends ASortEvent {
  final SortOption<T> sortOption;

  const SortChangeEvent({
    required this.sortOption,
  });

  @override
  List<Object?> get props => <Object?>[sortOption.id, sortOption.sortMode];
}
