import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_event/reached_bottom_infinity_list_event.dart';
import 'package:miro/blocs/abstract_blocs/infinity_list_bloc/infinity_list_state/infinity_list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/go_next_page_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loading_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/list/page_details.dart';
import 'package:miro/shared/utils/list_utils.dart';

abstract class InfinityListBloc<T> extends ListBloc<T> {
  /// Stores the last page index that was loaded.
  int scrolledIndex = 1;

  InfinityListBloc.init({
    required NetworkProvider networkProvider,
  }) : super.init(networkProvider: networkProvider) {
    on<ReachedBottomInfinityListEvent>(_mapReachedBottomInfinityListEventToState);
  }

  @override
  void notifyListUpdated(Emitter<ListState> emit) {
    List<T> data = _allPagesData;
    List<T> filteredList = getFilteredList(data);
    List<T> sortedList = getSortedList(filteredList);
    _updateCurrentPageDetails(sortedList);
    List<T> visibleList = sortedList.safeSublist(0, scrolledIndex * pageSize).toList();
    emit(InfinityListLoadedState<T>(
      data: visibleList,
      lastPage: currentPageDetails.lastPage,
    ));
  }

  @override
  void notifyListSorted(Emitter<ListState> emit) {
    scrolledIndex = 1;
    if (state is InfinityListLoadedState) {
      emit(ListLoadingState());
      notifyListUpdated(emit);
    }
  }

  @override
  void notifyFilterChanged(Emitter<ListState> emit) {
    scrolledIndex = 1;
    if (state is InfinityListLoadedState) {
      notifyListUpdated(emit);
    }
  }

  void _mapReachedBottomInfinityListEventToState(ReachedBottomInfinityListEvent event, Emitter<ListState> emit) {
    if (currentPageDetails.lastPage || loadingListStatus) {
      return;
    }
    scrolledIndex += 1;
    add(GetNextPageEvent());
  }

  List<T> get _allPagesData {
    List<T> data = List<T>.empty(growable: true);
    for (PageDetails<T> pageDetails in pagesCache.values) {
      data.addAll(pageDetails.data);
    }
    return data;
  }

  void _updateCurrentPageDetails(List<T> data) {
    List<T> currentPageItems = data.safeSublist((scrolledIndex - 1) * pageSize, scrolledIndex * pageSize);
    currentPageDetails = PageDetails<T>(
      index: scrolledIndex,
      data: currentPageItems,
      lastPage: currentPageItems.length < pageSize,
    );
  }
}
