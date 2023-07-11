import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_next_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_updated_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_next_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_previous_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/states/paginated_list_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/shared/utils/list_utils.dart';

class PaginatedListBloc<T extends AListItem> extends AListBloc<T> {
  int lastPageIndex = 0;

  PaginatedListBloc({
    required int singlePageSize,
    required IListController<T> listController,
    FavouritesBloc<T>? favouritesBloc,
    FiltersBloc<T>? filterBloc,
    SortBloc<T>? sortBloc,
  }) : super(
          singlePageSize: singlePageSize,
          listController: listController,
          favouritesBloc: favouritesBloc,
          filtersBloc: filterBloc,
          sortBloc: sortBloc,
        ) {
    on<PaginatedListNextPageEvent>(_mapNextPageEventToState);
    on<PaginatedListPreviousPageEvent>(_mapPreviousPageEventToState);
    on<ListUpdatedEvent>(_mapListUpdatedEventToState);
  }

  void _mapNextPageEventToState(PaginatedListNextPageEvent paginatedListNextPageEvent, Emitter<AListState> emit) {
    if (showLoadingOverlay.value) {
      return;
    }
    showLoadingOverlay.value = true;
    lastPageIndex += 1;
    add(const ListNextPageEvent());
  }

  void _mapPreviousPageEventToState(PaginatedListPreviousPageEvent paginatedListPreviousPageEvent, Emitter<AListState> emit) {
    if (showLoadingOverlay.value) {
      return;
    }
    showLoadingOverlay.value = true;
    lastPageIndex -= 1;
    add(const ListUpdatedEvent(jumpToTop: false));
  }

  void _mapListUpdatedEventToState(ListUpdatedEvent listUpdatedEvent, Emitter<AListState> emit) {
    if (listUpdatedEvent.jumpToTop) {
      lastPageIndex = 0;
    }
    List<T> allListItems = _getAllPagesAsList();
    List<T> filteredListItems = filterList(allListItems);
    List<T> sortedListItems = sortList(filteredListItems);

    _updateCurrentPageData(sortedListItems);

    emit(PaginatedListLoadedState<T>(
      pageIndex: lastPageIndex,
      listItems: currentPageData.listItems,
      lastPageBool: currentPageData.isLastPage,
    ));

    showLoadingOverlay.value = false;
  }

  List<T> _getAllPagesAsList() {
    List<T> allListItems = List<T>.empty(growable: true);
    for (PageData<T> pageData in downloadedPagesCache.values) {
      allListItems.addAll(pageData.listItems);
    }
    return allListItems;
  }

  void _updateCurrentPageData(List<T> allListItems) {
    List<T> currentPageItems = ListUtils.getSafeSublist<T>(
      list: allListItems,
      start: lastPageIndex * singlePageSize,
      end: (lastPageIndex + 1) * singlePageSize,
    );

    currentPageData = PageData<T>(
      index: lastPageIndex,
      listItems: currentPageItems,
      isLastPage: currentPageItems.length < singlePageSize,
    );
  }
}
