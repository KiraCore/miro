import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/events/list_init_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/events/list_next_page_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/events/list_options_changed_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/events/list_updated_event.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/page_details.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_disconnected_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/blocs/specific_blocs/list/filters/states/filters_active_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/states/filters_empty_state.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/list_utils.dart';

abstract class AListBloc<T extends AListItem> extends Bloc<AListEvent, AListState> {
  /// Network provider is used to get network url.
  /// If NetworkProvider hasn't network url specified, list will emit [ListDisconnectedState]
  final NetworkProvider networkProvider = globalLocator<NetworkProvider>();

  final IListController<T> listController;
  final FiltersBloc<T> filtersBloc;
  final SortBloc<T> sortBloc;
  final FavouritesBloc<T> favouritesBloc;

  final int singlePageSize;

  /// Stores information about current page.
  /// In case of infinity list, this is the last loaded page.
  PageDetails<T> currentPageDetails = PageDetails<T>.initial();

  /// Stores information about downloading new page status.
  /// If true, blocks the possibility of downloading another page (preventing duplicate queries)
  /// If false, allows downloading another page
  bool loadingListStatus = false;

  /// Stores all downloaded pages during widget lifecycle
  Map<int, PageDetails<T>> downloadedPagesCache = <int, PageDetails<T>>{};

  /// Is responsible for notifying list about loading status.
  /// This is set to true when the list downloads all items
  ValueNotifier<bool> showLoadingOverlay = ValueNotifier<bool>(false);

  AListBloc({
    required this.listController,
    required this.filtersBloc,
    required this.sortBloc,
    required this.favouritesBloc,
    required this.singlePageSize,
  }) : super(ListLoadingState()) {
    // Assign events to methods
    on<ListInitEvent>(_mapListInitEventToState);
    on<ListReloadEvent>(_mapListReloadEventToState);
    on<ListNextPageEvent>(_mapListNextPageEventToState);
    on<ListOptionsChangedEvent>(_mapListOptionsChangedEventToState);
    // Init listeners
    favouritesBloc.stream.listen((_) => add(const ListUpdatedEvent(jumpToTop: true)));
    filtersBloc.stream.listen((_) => add(ListOptionsChangedEvent()));
    sortBloc.stream.listen((_) => add(ListOptionsChangedEvent()));
    // Call InitListEvent
    add(ListInitEvent());
  }

  List<T> sortList(List<T> listItems) {
    SortOption<T> activeSortOption = sortBloc.state.activeSortOption;
    List<T> favouritesList = favouritesBloc.favouritesList;
    Set<T> uniqueListItems = <T>{
      ...activeSortOption.sort(filterList(favouritesList.toSet().toList())),
      ...activeSortOption.sort(listItems),
    };
    return uniqueListItems.toList();
  }

  List<T> filterList(List<T> listItems) {
    if (filtersBloc.state is FiltersEmptyState) {
      return listItems;
    }
    FilterComparator<T> filterComparator = (filtersBloc.state as FiltersActiveState<T>).filterComparator;
    return listItems.where(filterComparator).toList();
  }

  void _mapListInitEventToState(ListInitEvent listInitEvent, Emitter<AListState> emit) {
    // Reload list when network is changed
    networkProvider.addListener(() => add(ListReloadEvent()));
    add(ListReloadEvent());
  }

  Future<void> _mapListReloadEventToState(ListReloadEvent listReloadEvent, Emitter<AListState> emit) async {
    if (loadingListStatus) {
      return;
    }
    if (!networkProvider.isConnected) {
      emit(ListDisconnectedState());
      return;
    }
    emit(ListLoadingState());
    loadingListStatus = true;
    downloadedPagesCache.clear();
    currentPageDetails = PageDetails<T>.initial();
    await favouritesBloc.initFavourites();
    loadingListStatus = false;
    add(ListNextPageEvent());
  }

  Future<void> _mapListNextPageEventToState(ListNextPageEvent listNextPageEvent, Emitter<AListState> emit) async {
    if (loadingListStatus || currentPageDetails.lastPage) {
      return;
    }
    int nextPageIndex = currentPageDetails.index + 1;
    loadingListStatus = true;
    try {
      PageDetails<T> pageDetails = await _getPageDetails(nextPageIndex);
      if (pageDetails.listItems.length < singlePageSize) {
        pageDetails.lastPage = true;
      }
      downloadedPagesCache[nextPageIndex] = pageDetails;
      currentPageDetails = pageDetails;
      add(const ListUpdatedEvent(jumpToTop: false));
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch list data for page $nextPageIndex. Stack trace: ${e.toString()}');
      emit(ListErrorState());
    }
    loadingListStatus = false;
  }

  Future<void> _mapListOptionsChangedEventToState(
    ListOptionsChangedEvent listOptionsChangedEvent,
    Emitter<AListState> emit,
  ) async {
    await _downloadAllListData();
    add(const ListUpdatedEvent(jumpToTop: true));
  }

  Future<PageDetails<T>> _getPageDetails(int pageIndex) async {
    if (downloadedPagesCache[pageIndex] != null) {
      return downloadedPagesCache[pageIndex]!;
    } else {
      int offset = pageIndex * singlePageSize;
      List<T> pageListItems = await listController.getPageData(pageIndex, offset, singlePageSize);
      return PageDetails<T>(
        index: pageIndex,
        listItems: pageListItems,
        lastPage: pageListItems.length < singlePageSize,
      );
    }
  }

  Future<void> _downloadAllListData() async {
    PageDetails<T> lastPageDetails = downloadedPagesCache[downloadedPagesCache.keys.last]!;
    if (lastPageDetails.lastPage) {
      return;
    }
    showLoadingOverlay.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    List<T> allListItems = List<T>.empty(growable: true);
    int downloadedPagesCount = 0;
    int bulkSinglePageSize = AppConfig.bulkSinglePageSize;
    await Future.doWhile(() async {
      int offset = downloadedPagesCount * bulkSinglePageSize;
      List<T> currentPageItems = await listController.getPageData(downloadedPagesCount, offset, bulkSinglePageSize);
      allListItems.addAll(currentPageItems);
      downloadedPagesCount += 1;
      return currentPageItems.length == bulkSinglePageSize;
    });
    _setupPagesCacheFromList(allListItems);
    showLoadingOverlay.value = false;
  }

  void _setupPagesCacheFromList(List<T> allListItems) {
    for (int i = 0; i < allListItems.length; i += singlePageSize) {
      int pageIndex = i ~/ singlePageSize;
      List<T> pageListItems = ListUtils.getSafeSublist<T>(list: allListItems, start: i, end: i + singlePageSize);
      bool lastPage = i + singlePageSize >= allListItems.length - 1;
      downloadedPagesCache[pageIndex] = PageDetails<T>(
        index: pageIndex,
        listItems: pageListItems,
        lastPage: lastPage,
      );
    }
  }
}
