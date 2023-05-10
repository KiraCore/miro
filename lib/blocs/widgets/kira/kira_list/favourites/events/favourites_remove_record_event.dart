import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/a_favourites_event.dart';

class FavouritesRemoveRecordEvent<T extends AListItem> extends AFavouritesEvent {
  final T listItem;

  const FavouritesRemoveRecordEvent(this.listItem);

  @override
  List<Object?> get props => <Object?>[listItem.hashCode];
}
