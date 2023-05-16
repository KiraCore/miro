import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/a_favourites_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/a_favourites_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/states/favourites_loaded_state.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class FavouritesBloc<T extends AListItem> extends Bloc<AFavouritesEvent, AFavouritesState> {
  final IListController<T> listController;
  List<T> favouritesList = List<T>.empty(growable: true);

  FavouritesBloc({
    required this.listController,
  }) : super(FavouritesLoadedState<T>(favourites: List<T>.empty())) {
    on<FavouritesAddRecordEvent<T>>(_mapFavouritesAddRecordEventToState);
    on<FavouritesRemoveRecordEvent<T>>(_mapFavouritesRemoveRecordEventToState);
  }

  Future<void> initFavourites() async {
    try {
      List<T> newFavouritesList = await listController.getFavouritesData();
      for (T favouriteListItem in newFavouritesList) {
        favouriteListItem.favourite = true;
      }
      favouritesList = newFavouritesList;
    } catch (_) {
      AppLogger().log(message: 'Cannot fetch favourites');
      favouritesList = List<T>.empty(growable: true);
    }
  }

  void _mapFavouritesAddRecordEventToState(
    FavouritesAddRecordEvent<T> favouritesAddRecordEvent,
    Emitter<AFavouritesState> emit,
  ) {
    favouritesAddRecordEvent.listItem.favourite = true;
    favouritesList.add(favouritesAddRecordEvent.listItem);
    listController.getFavouriteCache().add(favouritesAddRecordEvent.listItem.cacheId);
    emit(FavouritesLoadedState<T>(favourites: List<T>.from(favouritesList)));
  }

  void _mapFavouritesRemoveRecordEventToState(
    FavouritesRemoveRecordEvent<T> favouritesRemoveRecordEvent,
    Emitter<AFavouritesState> emit,
  ) {
    favouritesRemoveRecordEvent.listItem.favourite = false;
    favouritesList.remove(favouritesRemoveRecordEvent.listItem);
    listController.getFavouriteCache().delete(favouritesRemoveRecordEvent.listItem.cacheId);
    emit(FavouritesLoadedState<T>(favourites: List<T>.from(favouritesList)));
  }
}
