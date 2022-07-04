import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/list_favourites_bloc/list_favourites_event.dart';
import 'package:miro/blocs/specific_blocs/lists/list_favourites_bloc/list_favourites_state.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';

class ListFavouritesBloc<T extends IListItem> extends Bloc<ListFavouritesEvent, ListFavouritesState> {
  final ListDataCubit<T> listDataCubit;
  List<T> favourites = List<T>.empty(growable: true);

  ListFavouritesBloc({
    required this.listDataCubit,
  }) : super(const ListFavouritesLoaded()) {
    on<AddFavouriteEvent<T>>(_mapAddFavouriteEventToState);
    on<RemoveFavouriteEvent<T>>(_mapRemoveFavouriteEventToState);
  }

  void _mapAddFavouriteEventToState(AddFavouriteEvent<T> searchEvent, Emitter<ListFavouritesState> emit) {
    searchEvent.item.isFavourite = true;
    favourites.add(searchEvent.item as T);
    listDataCubit.getFavouriteCache().add(searchEvent.item.cacheId);
    emit(const ListFavouritesLoaded());
  }

  void _mapRemoveFavouriteEventToState(RemoveFavouriteEvent<T> searchEvent, Emitter<ListFavouritesState> emit) {
    searchEvent.item.isFavourite = false;
    favourites.remove(searchEvent.item as T);
    listDataCubit.getFavouriteCache().delete(searchEvent.item.cacheId);
    emit(const ListFavouritesLoaded());
  }

  Future<void> initFavourites() async {
    try {
      favourites = await listDataCubit.getFavouritesData();
    } catch (_) {
      AppLogger().log(message: 'Cannot fetch favourites');
      favourites = List<T>.empty(growable: true);
    }
  }
}
