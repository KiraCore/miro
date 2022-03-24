import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/models/list/sorting_status.dart';

part 'list_event.dart';
part 'list_state.dart';

abstract class ListBloc<T> extends Bloc<ListEvent, ListState> {
  /// Defines how many items should be downloaded for single page
  static const int pageSize = 10;

  final NetworkProvider networkProvider;

  ListBloc({
    required this.networkProvider,
  }) : super(ListState()) {
    activeSortOption = defaultSortOption;
    on<InitListEvent>(_mapInitListEventToState);
    on<RefreshListEvent>(_mapRefreshListEventToState);
    on<GoToPageEvent>(_mapGoToPageEventToState);
    on<SortEvent<T>>(_mapSortEventToState);
    on<AddFilterEvent<T>>(_mapAddFilterEventToState);
    on<RemoveFilterEvent<T>>(_mapRemoveFilterEventToState);
    on<FilterEvent<T>>(_mapFilterEventToState);
  }

  ListBloc.init({
    required this.networkProvider,
  }) : super(ListState()) {
    activeSortOption = defaultSortOption;
    on<InitListEvent>(_mapInitListEventToState);
    on<RefreshListEvent>(_mapRefreshListEventToState);
    on<GoToPageEvent>(_mapGoToPageEventToState);
    on<SortEvent<T>>(_mapSortEventToState);
    on<AddFilterEvent<T>>(_mapAddFilterEventToState);
    on<RemoveFilterEvent<T>>(_mapRemoveFilterEventToState);
    on<FilterEvent<T>>(_mapFilterEventToState);
    add(InitListEvent());
  }

  /// Contains information about last used SortOption
  /// Used when list is filtered
  late SortOption<T> activeSortOption;

  /// Contains all items from all pages
  Set<T> allListItems = <T>{};

  /// Defines initial sort type
  SortOption<T> get defaultSortOption;

  /// Contains all active filters
  Set<FilterOption<T>> activeFilters = <FilterOption<T>>{};

  int currentPage = 0;

  void _mapInitListEventToState(InitListEvent event, Emitter<ListState> emit) {
    networkProvider.addListener(() => add(RefreshListEvent()));
    add(RefreshListEvent());
  }

  Future<void> _mapRefreshListEventToState(RefreshListEvent event, Emitter<ListState> emit) async {
    bool hasConnection = _checkConnection();
    if (!hasConnection) {
      emit(ListErrorState());
      return;
    } else {
      emit(ListLoadingState());
    }
    allListItems.clear();
    currentPage = 0;
    Set<T> newListItems = await downloadListData();
    newListItems = getSortedList(newListItems);
    allListItems = newListItems;

    int maxPagesIndex = _calculateMaxPagesCount(newListItems.length);
    bool listEndStatus = 0 >= maxPagesIndex;

    emit(ListLoadedState<T>(
      allListItems: newListItems,
      itemsFromStart: _getItemsFromStart(newListItems.toList(), 0),
      pageListItems: _getCurrentPageData(newListItems.toList(), 0),
      listEndStatus: listEndStatus,
      currentPageIndex: 0,
      maxPagesIndex: maxPagesIndex,
    ));
  }

  Future<Set<T>> downloadListData();

  void _mapGoToPageEventToState(GoToPageEvent event, Emitter<ListState> emit) {
    ListState listState = state;
    if (listState is ListLoadedState<T>) {
      currentPage = event.pageIndex;
      int maxPagesIndex = _calculateMaxPagesCount(listState.allListItems.length);
      bool listEndStatus = event.pageIndex >= maxPagesIndex;
      emit(ListSortedState<T>(
        allListItems: listState.allListItems,
        itemsFromStart: _getItemsFromStart(listState.allListItems.toList(), event.pageIndex),
        pageListItems: _getCurrentPageData(listState.allListItems.toList(), event.pageIndex),
        listEndStatus: listEndStatus,
        currentPageIndex: event.pageIndex,
        maxPagesIndex: maxPagesIndex,
      ));
    }
  }

  Future<void> _mapSortEventToState(SortEvent<T> event, Emitter<ListState> emit) async {
    ListState listState = state;
    if (listState is ListLoadedState<T>) {
      if (event.sortOption != null) {
        activeSortOption = event.sortOption!;
      }
      Set<T> sortedList = getSortedList(listState.allListItems);
      emit(ListSortedState<T>(
        allListItems: sortedList,
        itemsFromStart: _getItemsFromStart(sortedList.toList(), listState.currentPageIndex),
        pageListItems: _getCurrentPageData(sortedList.toList(), listState.currentPageIndex),
        listEndStatus: listState.listEndStatus,
        currentPageIndex: listState.currentPageIndex,
        maxPagesIndex: listState.maxPagesIndex,
      ));
    }
  }

  Future<void> _mapAddFilterEventToState(AddFilterEvent<T> event, Emitter<ListState> emit) async {
    activeFilters.add(event.filterComparator);
    add(FilterEvent<T>());
  }

  Future<void> _mapRemoveFilterEventToState(RemoveFilterEvent<T> event, Emitter<ListState> emit) async {
    activeFilters.remove(event.filterComparator);
    add(FilterEvent<T>());
  }

  Future<void> _mapFilterEventToState(FilterEvent<T> event, Emitter<ListState> emit) async {
    ListState listState = state;
    if (listState is ListLoadedState<T>) {
      Set<T> itemsToFilter = allListItems;
      if (event is SearchEvent<T>) {
        itemsToFilter = itemsToFilter.where(event.searchComparator).toSet();
      }
      Set<T> filteredItems = _filterList(itemsToFilter);
      Set<T> filteredSortedList = getSortedList(filteredItems);
      int maxPagesIndex = _calculateMaxPagesCount(filteredSortedList.length);
      bool listEndStatus = 0 >= maxPagesIndex;

      emit(event.prepareState(
        allListItems: filteredSortedList,
        itemsFromStart: _getItemsFromStart(filteredSortedList.toList(), 0),
        pageListItems: _getCurrentPageData(filteredSortedList.toList(), 0),
        listEndStatus: listEndStatus,
        currentPageIndex: 0,
        maxPagesIndex: maxPagesIndex,
      ));
      currentPage = 0;
    }
  }

  Set<T> _getCurrentPageData(List<T> listItems, int pageIndex) {
    int pagesMinIndex = pageIndex * pageSize;
    int pagesMaxIndex = (pageIndex + 1) * pageSize;
    if (listItems.length < pagesMaxIndex) {
      return listItems.sublist(pagesMinIndex, listItems.length).toSet();
    }
    return listItems.sublist(pagesMinIndex, pagesMaxIndex).toSet();
  }

  Set<T> _getItemsFromStart(List<T> listItems, int pageIndex) {
    int pagesMaxIndex = (pageIndex + 1) * pageSize;
    if (listItems.length < pagesMaxIndex) {
      return listItems.sublist(0, listItems.length).toSet();
    }
    return listItems.sublist(0, pagesMaxIndex).toSet();
  }

  bool _checkConnection() {
    if (networkProvider.isConnected) {
      return true;
    }
    return false;
  }

  int _calculateMaxPagesCount(int listLength) {
    return (listLength / pageSize).floor();
  }

  Set<T> _filterList(Set<T> listItems) {
    return listItems.where((T item) {
      if (activeFilters.isEmpty) {
        return true;
      }
      for (FilterOption<T> filter in activeFilters) {
        if (filter.comparator(item)) {
          return true;
        }
      }
      return false;
    }).toSet();
  }

  /// Calls the sortList() method that returns a sorted list of list items
  ///
  /// This method is overridden in some children
  /// For example in [BalanceListBloc] we need to sort favorites balances and other balances separately
  Set<T> getSortedList(Set<T> listItems) {
    return sortList(listItems);
  }

  /// Stores logic of sorting lists
  /// It's called by getSortedList()
  ///
  /// If you want to override the sort functionality, you probably mean getSortedList method
  Set<T> sortList(Set<T> listItems) {
    List<T> sortedItems = listItems.toList()
      ..sort(
        (T a, T b) {
          int sortStatus = activeSortOption.comparator(a, b);
          if (activeSortOption.sortingStatus == SortingStatus.desc) {
            sortStatus = sortStatus * -1;
          }
          return sortStatus;
        },
      );
    return sortedItems.toSet();
  }
}
