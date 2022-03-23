import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sorting_status.dart';

part 'list_event.dart';
part 'list_state.dart';

abstract class ListBloc<T> extends Bloc<ListEvent, ListState> {
  /// Defines how many items should be downloaded for single page
  static const int pageSize = 20;

  final NetworkProvider networkProvider;

  ListBloc({
    required this.networkProvider,
  }) : super(ListState()) {
    activeSortOption = defaultSortOption;
    on<InitListEvent>(_mapInitListEventToState);
    on<RefreshListEvent>(_mapRefreshListEventToState);
    on<GetNextPageEvent>(_mapGetNextPageEventToState);
    on<SortEvent<T>>(_mapSortEventToState);
    on<FilterEvent<T>>(_mapFilterEventToState);
  }

  ListBloc.init({
    required this.networkProvider,
  }) : super(ListState()) {
    activeSortOption = defaultSortOption;
    on<InitListEvent>(_mapInitListEventToState);
    on<RefreshListEvent>(_mapRefreshListEventToState);
    on<GetNextPageEvent>(_mapGetNextPageEventToState);
    on<SortEvent<T>>(_mapSortEventToState);
    on<FilterEvent<T>>(_mapFilterEventToState);
    add(InitListEvent());
  }

  /// Contains information about last used SortOption
  /// Used when list is filtered
  late SortOption<T> activeSortOption;

  /// Contains all items from all pages
  Set<T> allListItems = <T>{};

  /// Contains actual visible items
  Set<T> visibleListItems = <T>{};

  /// Current page index
  int pageIndex = 0;

  /// Defines initial sort type
  SortOption<T> get defaultSortOption;

  /// List end status
  /// If false, load more spinner is visible
  /// If true, hide load more spinner
  bool listEnd = false;

  bool fetchingStatus = false;

  void _mapInitListEventToState(InitListEvent event, Emitter<ListState> emit) {
    networkProvider.addListener(() => add(RefreshListEvent()));
    add(RefreshListEvent());
  }

  void _mapRefreshListEventToState(RefreshListEvent event, Emitter<ListState> emit) {
    emit(ListLoadingState());
    bool hasConnection = _checkConnection();
    if (!hasConnection) {
      emit(ListErrorState());
    }
    allListItems.clear();
    visibleListItems.clear();
    listEnd = false;
    pageIndex = 0;
    add(GetNextPageEvent());
  }

  Future<void> _mapGetNextPageEventToState(GetNextPageEvent event, Emitter<ListState> emit) async {
    if (listEnd || fetchingStatus) {
      return;
    }
    fetchingStatus = true;
    bool hasConnection = _checkConnection();
    if (hasConnection) {
      Set<T> pageData = await fetchPageData(pageIndex);
      allListItems.addAll(pageData);
      visibleListItems.addAll(pageData);
      visibleListItems = getSortedList(visibleListItems);
      listEnd = pageData.length < pageSize;
      if (pageIndex == 0 && pageData.isEmpty) {
        emit(ListEmptyState<T>(listItems: visibleListItems, listEndStatus: true));
      } else {
        emit(ListLoadedState<T>(listItems: visibleListItems, listEndStatus: listEnd));
      }
      pageIndex += 1;
    }
    fetchingStatus = false;
  }

  Future<void> _mapSortEventToState(SortEvent<T> event, Emitter<ListState> emit) async {
    if (event.sortOption != null) {
      activeSortOption = event.sortOption!;
    }
    visibleListItems = getSortedList(visibleListItems);
    emit(ListSortedState<T>(
      listItems: visibleListItems,
      listEndStatus: listEnd,
    ));
  }

  Future<void> _mapFilterEventToState(FilterEvent<T> event, Emitter<ListState> emit) async {
    Set<T> filteredItems = _filterList(allListItems, event.filterComparator);
    visibleListItems = getSortedList(filteredItems);
    emit(event.prepareState(
      filteredItems: visibleListItems,
      listEndStatus: true,
    ));
  }

  bool _checkConnection() {
    if (networkProvider.isConnected) {
      return true;
    }
    return false;
  }

  Set<T> _filterList(Set<T> listItems, bool Function(T item) filter) {
    return listItems.where(filter).toSet();
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

  Future<Set<T>> fetchPageData(int pageIndex);
}
