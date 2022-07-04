import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_event/reached_bottom_infinity_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_updated_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/next_page_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loaded_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loading_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_state.dart';
import 'package:miro/blocs/specific_blocs/lists/list_favourites_bloc/list_favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/utils/list/filter_option.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/shared/utils/list/page_details.dart';
import 'package:miro/shared/utils/list/sort_option.dart';
import 'package:miro/shared/utils/list_utils.dart';

class InfinityListBloc<T extends IListItem> extends ListBloc<T> {
  /// Stores the last page index that was loaded.
  int scrolledIndex = 1;

  InfinityListBloc({
    required NetworkProvider networkProvider,
    required ListDataCubit<T> listDataCubit,
    required FilterOptionsBloc<T> filterOptionsBloc,
    required SortOptionBloc<T> sortOptionBloc,
    required ListFavouritesBloc<T> listFavouritesBloc,
    required int pageSize,
  }) : super(
          networkProvider: networkProvider,
          listDataCubit: listDataCubit,
          filterOptionsBloc: filterOptionsBloc,
          sortOptionBloc: sortOptionBloc,
          listFavouritesBloc: listFavouritesBloc,
          pageSize: pageSize,
        ) {
    on<ReachedBottomInfinityListEvent>(_mapReachedBottomInfinityListEventToState);
    on<ListUpdatedEvent>(_mapListUpdatedEventToState);
  }

  void _mapReachedBottomInfinityListEventToState(
    ReachedBottomInfinityListEvent reachedBottomInfinityListEvent,
    Emitter<ListState> emit,
  ) {
    if (currentPageDetails.lastPage || loadingListStatus) {
      return;
    }
    scrolledIndex += 1;
    add(NextPageEvent());
  }

  void _mapListUpdatedEventToState(ListUpdatedEvent listUpdatedEvent, Emitter<ListState> emit) {
    print('list updated');
    if (listUpdatedEvent.jumpToTop) {
      scrolledIndex = 1;
    }
    List<T> data = _getAllPagesAsList();
    List<T> filteredList = filterList(data);
    List<T> sortedList = sortList(filteredList);
    _updateCurrentPageDetails(sortedList);
    List<T> visibleList = ListUtils.safeSublist(sortedList, 0, scrolledIndex * pageSize).toList() as List<T>;
    emit(ListLoadingState());
    emit(ListLoadedState<T>(
      data: visibleList,
      lastPage: currentPageDetails.lastPage,
    ));
  }

  List<T> sortList(List<T> listItems) {
    SortOption<T> activeSortOption = sortOptionBloc.state.activeSortOption;
    Set<T> favouriteItems = listFavouritesBloc.favourites.toSet();
    print(favouriteItems);
    Set<T> uniqueItems = <T>{
      ...activeSortOption.sort(filterList(favouriteItems.toList())),
      ...activeSortOption.sort(listItems),
    };
    return uniqueItems.toList();
  }

  List<T> filterList(List<T> listItems) {
    if (filterOptionsBloc.state is EmptyFiltersState) {
      return listItems;
    }
    FilterComparator<T> filterComparator = (filterOptionsBloc.state as FiltersActiveState<T>).filterComparator;
    return listItems.where(filterComparator).toList();
  }

  List<T> _getAllPagesAsList() {
    List<T> data = List<T>.empty(growable: true);
    for (PageDetails<T> pageDetails in pagesCache.values) {
      data.addAll(pageDetails.data);
    }
    return data;
  }

  void _updateCurrentPageDetails(List<T> data) {
    List<T> currentPageItems =
        ListUtils.safeSublist(data, (scrolledIndex - 1) * pageSize, scrolledIndex * pageSize) as List<T>;
    currentPageDetails = PageDetails<T>(
      index: scrolledIndex,
      data: currentPageItems,
      lastPage: currentPageItems.length < pageSize,
    );
  }
}
