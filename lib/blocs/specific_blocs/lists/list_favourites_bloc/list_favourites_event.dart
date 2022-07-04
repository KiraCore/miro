import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';

class ListFavouritesEvent extends Equatable {
  const ListFavouritesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AddFavouriteEvent<T extends IListItem> extends ListFavouritesEvent {
  final IListItem item;

  const AddFavouriteEvent(this.item);

  @override
  List<Object?> get props => <Object?>[item.hashCode];
}

class RemoveFavouriteEvent<T extends IListItem> extends ListFavouritesEvent {
  final IListItem item;

  const RemoveFavouriteEvent(this.item);

  @override
  List<Object?> get props => <Object?>[item.hashCode];
}
