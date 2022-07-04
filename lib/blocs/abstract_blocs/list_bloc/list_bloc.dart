import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/init_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_options_changed_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_updated_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/next_page_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/reload_list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_error_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_loading_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/no_interx_connection_state.dart';
import 'package:miro/blocs/abstract_blocs/list_data_cubit/list_data_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/list_favourites_bloc/list_favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/list/filter_option.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/shared/utils/list/page_details.dart';

typedef SearchComparator<T> = FilterComparator<T> Function(String searchText);

abstract class ListBloc<T extends IListItem> extends Bloc<ListEvent, ListState> {
  /// Network provider is used to get network url.
  /// If NetworkProvider hasn't network url specified, list will emit [NoInterxConnectionState]
  final NetworkProvider networkProvider;

  final ListDataCubit<T> listDataCubit;
  final FilterOptionsBloc<T> filterOptionsBloc;
  final SortOptionBloc<T> sortOptionBloc;
  final ListFavouritesBloc<T> listFavouritesBloc;

  final int pageSize;

  /// Stores all downloaded pages during widget lifecycle
  Map<int, PageDetails<T>> pagesCache = <int, PageDetails<T>>{};

  /// Stores information about current page.
  /// In case of infinity list, this is the last loaded page.
  PageDetails<T> currentPageDetails = PageDetails<T>.initial();

  /// Is responsible for notifying list about loading status.
  /// This is set to true when the list downloads all items
  ValueNotifier<bool> showLoadingOverlay = ValueNotifier<bool>(false);

  /// Stores information about downloading new page status.
  /// If true, blocks the possibility of downloading another page (preventing duplicate queries)
  /// If false, allows downloading another page
  bool loadingListStatus = false;

  ListBloc({
    required this.networkProvider,
    required this.listDataCubit,
    required this.filterOptionsBloc,
    required this.sortOptionBloc,
    required this.listFavouritesBloc,
    required this.pageSize,
  }) : super(ListLoadingState()) {
    // Assign events to methods
    on<InitListEvent>(_mapInitListEventToState);
    on<ReloadListEvent>(_mapReloadListEventToState);
    on<NextPageEvent>(_mapGetNextPageEventToState);
    on<ListOptionsChangedEvent>(_mapListOptionsChangedEventToState);
    // Init listeners
    filterOptionsBloc.stream.listen((_) => add(ListOptionsChangedEvent()));
    sortOptionBloc.stream.listen((_) => add(ListOptionsChangedEvent()));
    listFavouritesBloc.stream.listen((_) {
      print('favourites updated');
      add(ListUpdatedEvent(jumpToTop: true));
    });

    // Call InitListEvent
    add(InitListEvent());
  }

  void _mapInitListEventToState(InitListEvent initListEvent, Emitter<ListState> emit) {
    // Reload list when network is changed
    networkProvider.addListener(() => add(ReloadListEvent()));
    add(ReloadListEvent());
  }

  Future<void> _mapReloadListEventToState(ReloadListEvent reloadListEvent, Emitter<ListState> emit) async {
    if (loadingListStatus) {
      return;
    }
    if (!networkProvider.isConnected) {
      emit(NoInterxConnectionState());
      return;
    }
    emit(ListLoadingState());
    loadingListStatus = true;
    pagesCache.clear();
    currentPageDetails = PageDetails<T>.initial();
    await listFavouritesBloc.initFavourites();
    loadingListStatus = false;
    add(NextPageEvent());
  }

  Future<void> _mapGetNextPageEventToState(NextPageEvent nextPageEvent, Emitter<ListState> emit) async {
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
      add(ListUpdatedEvent(jumpToTop: false));
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch list data for page $index. Stack trace: ${e.toString()}');
      emit(ListErrorState());
    }
    loadingListStatus = false;
  }

  Future<void> _mapListOptionsChangedEventToState(
    ListOptionsChangedEvent displayConditionsChangedEvent,
    Emitter<ListState> emit,
  ) async {
    await _downloadAllListData();
    add(ListUpdatedEvent(jumpToTop: true));
  }

  Future<PageDetails<T>> _getPageDetails(int pageIndex) async {
    if (pagesCache[pageIndex] != null) {
      return pagesCache[pageIndex]!;
    } else {
      int offset = pageIndex * pageSize;
      List<T> pageListItems = await listDataCubit.getPageData(pageIndex, offset, pageSize);
      return PageDetails<T>(
        index: pageIndex,
        data: pageListItems,
        lastPage: pageListItems.length < pageSize,
      );
    }
  }

  Future<void> _downloadAllListData() async {
    PageDetails<T> lastPageDetails = pagesCache[pagesCache.keys.last]!;
    if (lastPageDetails.lastPage) {
      return;
    }
    showLoadingOverlay.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    List<T> allPageItems = List<T>.empty(growable: true);
    int downloadedPagesCount = 0;
    await Future.doWhile(() async {
      int customPageSize = 500;
      int offset = downloadedPagesCount * customPageSize;
      List<T> currentPageItems = await listDataCubit.getPageData(downloadedPagesCount, offset, customPageSize);
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
}
