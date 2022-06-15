import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/add_filter_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/go_next_page_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/init_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/reload_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/remove_filter_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/search_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/sort_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_error_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loading_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/no_interx_connection_state.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/page_details.dart';
import 'package:miro/shared/models/list/search_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class ListBloc<T> extends Bloc<ListEvent, ListState> {
  /// Network provider is used to get network url.
  /// If NetworkProvider hasn't network url specified, list will emit [NoInterxConnectionState]
  final NetworkProvider networkProvider;

  /// Stores information about selected sorting type
  /// [defaultSortOption] must be defined in child classes
  late SortOption<T> activeSortOption = defaultSortOption;

  /// Stores information about selected filters
  Set<FilterOption<T>> activeFilterOptions = <FilterOption<T>>{};

  /// Stores all downloaded pages during widget lifecycle
  Map<int, PageDetails<T>> pagesCache = <int, PageDetails<T>>{};

  /// Stores information about current page.
  /// In case of infinity list, this is the loaded page.
  PageDetails<T> currentPageDetails = PageDetails<T>.initial();

  /// Is responsible for notifying list about loading status.
  /// This is set to true when the list downloads all items
  ValueNotifier<bool> showLoadingOverlay = ValueNotifier<bool>(false);

  /// Stores information about downloading new page status.
  /// If true, blocks the possibility of downloading another page (preventing duplicate queries)
  /// If false, allows downloading another page
  bool loadingListStatus = false;

  ListBloc.init({
    required this.networkProvider,
  }) : super(ListLoadingState()) {
    // Assign events to methods
    on<InitListEvent>(_mapInitListEventToState);
    on<ReloadListEvent>(_mapReloadListEventToState);
    on<GetNextPageEvent>(_mapGetNextPageEventToState);
    on<SortEvent<T>>(_mapSortEventToState);
    on<AddFilterEvent<T>>(_mapAddFilterEventToState);
    on<SearchEvent<T>>(_mapSearchEventToState);
    on<RemoveFilterEvent<T>>(_mapRemoveFilterEventToState);
    // Call InitListEvent
    add(InitListEvent());
  }

  void _mapInitListEventToState(InitListEvent event, Emitter<ListState> emit) {
    // Reload list when network is changed
    networkProvider.addListener(() => add(ReloadListEvent()));
    add(ReloadListEvent());
  }

  Future<void> _mapReloadListEventToState(ReloadListEvent event, Emitter<ListState> emit) async {
    if (loadingListStatus) {
      return;
    }
    try {
      emit(ListLoadingState());
      if (!networkProvider.isConnected) {
        emit(NoInterxConnectionState());
      } else {
        loadingListStatus = true;
        pagesCache.clear();
        currentPageDetails = PageDetails<T>.initial();
        await onListInitialized();
        loadingListStatus = false;
        add(GetNextPageEvent());
      }
    } catch (e) {
      AppLogger().log(message: 'Cannot init list. Stack trace: ${e.toString()}');
      emit(ListErrorState());
    }
  }

  Future<void> _mapGetNextPageEventToState(GetNextPageEvent event, Emitter<ListState> emit) async {
    if (loadingListStatus || currentPageDetails.lastPage) {
      return;
    }
    int index = currentPageDetails.index + 1;
    loadingListStatus = true;
    try {
      PageDetails<T> pageData = await _getPageDetails(index);
      if (pageData.data.length < pageSize) {
        pageData.lastPage = true;
      }
      pagesCache[index] = pageData;
      currentPageDetails = pageData;
      notifyListUpdated(emit);
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch list data for page $index. Stack trace: ${e.toString()}');
      emit(ListErrorState());
    }
    loadingListStatus = false;
  }

  Future<void> _mapSortEventToState(SortEvent<T> event, Emitter<ListState> emit) async {
    await _downloadAllListData();
    activeSortOption = event.sortOption ?? defaultSortOption;
    notifyListSorted(emit);
  }

  Future<void> _mapAddFilterEventToState(AddFilterEvent<T> event, Emitter<ListState> emit) async {
    await _downloadAllListData();
    activeFilterOptions.add(event.filterOption);
    notifyFilterChanged(emit);
  }

  Future<void> _mapRemoveFilterEventToState(RemoveFilterEvent<T> event, Emitter<ListState> emit) async {
    await _downloadAllListData();
    activeFilterOptions.remove(event.filterOption);
    notifyFilterChanged(emit);
  }

  Future<void> _mapSearchEventToState(SearchEvent<T> event, Emitter<ListState> emit) async {
    activeFilterOptions.removeWhere((FilterOption<T> e) => e is SearchOption);
    FilterComparator<T>? filterComparator = getSearchComparator(event.searchText);
    if (filterComparator == null) {
      AppLogger().log(message: 'This ListBlock not support search option');
      return;
    }
    if (event.searchText.isEmpty) {
      activeFilterOptions.removeWhere((FilterOption<T> e) => e is SearchOption);
    } else {
      await _downloadAllListData();
      activeFilterOptions.add(SearchOption<T>(filterComparator));
    }
    notifyFilterChanged(emit);
  }

  /// By default, this method does nothing.
  /// It can be overridden in child classes to perform additional actions when list is initialized.
  /// For example: If we need to download favourite items before showing list, we have to do it here
  Future<void> onListInitialized() async {
    return Future<void>.value();
  }

  /// Returns list of items matching current filter options.
  List<T> getFilteredList(List<T> listItems) {
    Set<T> data = <T>{};
    if (activeFilterOptions.isEmpty) {
      return listItems;
    }
    List<FilterOption<T>> forceFilters = activeFilterOptions.where((FilterOption<T> e) => e.force).toList();
    List<FilterOption<T>> softFilters = activeFilterOptions.where((FilterOption<T> e) => !e.force).toList();
    for (T item in listItems) {
      bool matchAllForceFilters = _hasForceFilterMatch(forceFilters, item);
      bool matchAnySoftFilters = _hasSoftFilterMatch(softFilters, item, softFilters.isEmpty);
      if (matchAllForceFilters && matchAnySoftFilters) {
        data.add(item);
      }
    }
    return data.toList();
  }

  Future<PageDetails<T>> _getPageDetails(int pageIndex) async {
    if (pagesCache[pageIndex] != null) {
      return pagesCache[pageIndex]!;
    } else {
      int offset = pageIndex * pageSize;
      List<T> pageListItems = await fetchPageData(pageIndex, offset, pageSize);
      return PageDetails<T>(
        index: pageIndex,
        data: pageListItems,
        lastPage: pageListItems.length < pageSize,
      );
    }
  }

  Future<void> _downloadAllListData() async {
    if (pagesCache[pagesCache.length - 1] == null || pagesCache[pagesCache.length - 1]!.lastPage) {
      return;
    }
    showLoadingOverlay.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    List<T> allPageItems = List<T>.empty(growable: true);
    int downloadedPagesCount = 0;
    await Future.doWhile(() async {
      int customPageSize = 500;
      int offset = downloadedPagesCount * customPageSize;
      List<T> currentPageItems = await fetchPageData(downloadedPagesCount, offset, customPageSize);
      allPageItems.addAll(currentPageItems);
      downloadedPagesCount += 1;
      return currentPageItems.length == customPageSize;
    });
    _setupPagesCacheFromList(allPageItems);
    showLoadingOverlay.value = false;
  }

  void _setupPagesCacheFromList(List<T> itemsArray) {
    for (int i = 0; i < itemsArray.length; i += pageSize) {
      int pageIndex = i ~/ pageSize;
      bool lastPage = i + pageSize >= itemsArray.length - 1;
      List<T> pageData = itemsArray.sublist(i, lastPage ? itemsArray.length : i + pageSize);
      pagesCache[pageIndex] = PageDetails<T>(
        index: pageIndex,
        data: pageData,
        lastPage: lastPage,
      );
    }
  }

  bool _hasForceFilterMatch(List<FilterOption<T>> filters, T item) {
    bool hasMatch = true;
    for (FilterOption<T> filterOption in filters) {
      if (!filterOption.hasMatch(item)) {
        hasMatch = false;
      }
    }
    return hasMatch;
  }

  bool _hasSoftFilterMatch(List<FilterOption<T>> filters, T item, bool initialValue) {
    bool hasMatch = initialValue;
    for (FilterOption<T> filterOption in filters) {
      if (filterOption.hasMatch(item)) {
        hasMatch = true;
      }
    }
    return hasMatch;
  }

  /// Calls the sortList() method that returns a sorted list of list items
  ///
  /// It can be override to provide custom sorting logic.
  /// For example: In case of favourites, we want to sort favourite items and rest of items separately.
  List<T> getSortedList(List<T> listItems) {
    return activeSortOption.sort(listItems);
  }

  /// Default page size.
  /// Must be overridden in child classes.
  int get pageSize;

  /// Default sort option
  /// Must be overridden in child classes.
  SortOption<T> get defaultSortOption;

  /// Returns a list of list items for specified page.
  /// Must be overridden in child classes.
  Future<List<T>> fetchPageData(int pageIndex, int offset, int limit);

  /// Returns a comparator with conditions for searching items
  /// If null is returned, search option is not supported.
  /// Must be overridden in child classes.
  FilterComparator<T>? getSearchComparator(String searchText);

  /// Should emit state after list updated
  /// Must be overridden in child classes.
  void notifyListUpdated(Emitter<ListState> emit);

  /// Should emit state after sort changed
  /// Must be overridden in child classes.
  void notifyListSorted(Emitter<ListState> emit);

  /// Should emit state after filter changed
  /// Must be overridden in child classes.
  void notifyFilterChanged(Emitter<ListState> emit);
}
