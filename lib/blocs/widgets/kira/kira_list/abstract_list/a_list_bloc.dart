import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_next_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_options_changed_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_updated_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_error_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/a_favourites_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/a_filters_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/states/filters_active_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/states/filters_empty_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/utils/list_utils.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class AListBloc<T extends AListItem> extends Bloc<AListEvent, AListState> {
  final AppConfig appConfig = globalLocator<AppConfig>();

  final FavouritesBloc<T> favouritesBloc;
  final FiltersBloc<T> filtersBloc;
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final SortBloc<T> sortBloc;

  late StreamSubscription<AFavouritesState> _favouritesStateSubscription;
  late StreamSubscription<AFiltersState<T>> _filtersStateSubscription;
  late StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;
  late StreamSubscription<SortState<T>> _sortStateSubscription;

  final IListController<T> listController;

  final PageReloadController pageReloadController = PageReloadController();

  final int singlePageSize;

  final ReloadNotifierModel? reloadNotifierModel;

  /// Stores information about current page.
  /// In case of infinity list, this is the last loaded page.
  PageData<T> currentPageData = PageData<T>.initial();

  /// Stores all downloaded pages during widget lifecycle
  Map<int, PageData<T>> downloadedPagesCache = <int, PageData<T>>{};

  /// If true, blocks InfinityListBloc from downloading next page
  bool pageDownloadingStatus = false;

  /// Is responsible for notifying list about loading status.
  /// This is set to true when the list downloads all items
  ValueNotifier<bool> showLoadingOverlay = ValueNotifier<bool>(false);

  AListBloc({
    required this.favouritesBloc,
    required this.filtersBloc,
    required this.sortBloc,
    required this.listController,
    required this.singlePageSize,
    this.reloadNotifierModel,
  }) : super(ListLoadingState()) {
    // Assign events to methods
    on<ListReloadEvent>(_mapListReloadEventToState);
    on<ListNextPageEvent>(_mapListNextPageEventToState);
    on<ListOptionsChangedEvent>(_mapListOptionsChangedEventToState);

    // Init listeners
    reloadNotifierModel?.addListener(_handleReloadNotifierUpdate);

    _favouritesStateSubscription = favouritesBloc.stream.listen((_) => add(const ListUpdatedEvent(jumpToTop: true)));
    _filtersStateSubscription = filtersBloc.stream.listen((_) => add(ListOptionsChangedEvent()));
    _networkModuleStateSubscription = networkModuleBloc.stream.listen(_reloadAfterNetworkModuleStateChanged);
    _networkModuleStateSubscription = networkModuleBloc.stream.listen(_reloadAfterNetworkModuleStateChanged);
    _sortStateSubscription = sortBloc.stream.listen((_) => add(ListOptionsChangedEvent()));

    // Call ListReloadEvent to fetch first page
    add(ListReloadEvent());
  }

  @override
  Future<void> close() async {
    reloadNotifierModel?.removeListener(_handleReloadNotifierUpdate);

    await _favouritesStateSubscription.cancel();
    await _filtersStateSubscription.cancel();
    await _networkModuleStateSubscription.cancel();
    await _sortStateSubscription.cancel();
    return super.close();
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

  Future<void> _mapListReloadEventToState(ListReloadEvent listReloadEvent, Emitter<AListState> emit) async {
    ANetworkStatusModel networkStatusModel = networkModuleBloc.state.networkStatusModel;

    if (networkStatusModel is NetworkOfflineModel) {
      emit(ListErrorState());
      return;
    }

    pageReloadController.handleReloadCall(networkStatusModel);
    int localReloadId = pageReloadController.activeReloadId;

    emit(ListLoadingState());

    downloadedPagesCache.clear();
    currentPageData = PageData<T>.initial();

    await favouritesBloc.initFavourites();

    bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
    bool isBlocActive = !isClosed;
    if (canReloadComplete && isBlocActive) {
      add(ListNextPageEvent());
    }
  }

  Future<void> _mapListNextPageEventToState(ListNextPageEvent listNextPageEvent, Emitter<AListState> emit) async {
    int localReloadId = pageReloadController.activeReloadId;
    int nextPageIndex = currentPageData.index + 1;
    pageDownloadingStatus = true;
    try {
      PageData<T> pageData = await _getPageData(nextPageIndex);

      downloadedPagesCache[nextPageIndex] = pageData;
      currentPageData = pageData;

      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      bool isBlocActive = !isClosed;
      if (canReloadComplete && isBlocActive) {
        add(const ListUpdatedEvent(jumpToTop: false));
      }
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch list data for page $nextPageIndex');
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete) {
        pageReloadController.hasErrors = true;
        emit(ListErrorState());
      }
    }
    pageDownloadingStatus = false;
  }

  Future<void> _mapListOptionsChangedEventToState(
    ListOptionsChangedEvent listOptionsChangedEvent,
    Emitter<AListState> emit,
  ) async {
    await _downloadAllListData();
    add(const ListUpdatedEvent(jumpToTop: true));
  }

  void _handleReloadNotifierUpdate() {
    add(ListReloadEvent());
  }

  void _reloadAfterNetworkModuleStateChanged(NetworkModuleState networkModuleState) {
    ANetworkStatusModel networkStatusModel = networkModuleBloc.state.networkStatusModel;

    bool hasErrors = pageReloadController.hasErrors;
    bool hasNetworkChanged = pageReloadController.hasNetworkChanged(networkStatusModel);
    bool shouldReload = hasErrors || hasNetworkChanged;

    if (isClosed == false && shouldReload) {
      add(ListReloadEvent());
    }
  }

  Future<PageData<T>> _getPageData(int pageIndex) async {
    if (downloadedPagesCache[pageIndex] != null) {
      return downloadedPagesCache[pageIndex]!;
    } else {
      int offset = pageIndex * singlePageSize;
      List<T> pageListItems = await listController.getPageData(pageIndex, offset, singlePageSize);
      return PageData<T>(
        index: pageIndex,
        listItems: pageListItems,
        isLastPage: pageListItems.length < singlePageSize,
      );
    }
  }

  Future<void> _downloadAllListData() async {
    PageData<T> lastPageData = downloadedPagesCache[downloadedPagesCache.keys.last]!;
    if (lastPageData.isLastPage) {
      return;
    }
    showLoadingOverlay.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    List<T> allListItems = List<T>.empty(growable: true);
    int downloadedPagesCount = 0;
    int bulkSinglePageSize = appConfig.bulkSinglePageSize;
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
      bool isLastPage = i + singlePageSize >= allListItems.length - 1;
      downloadedPagesCache[pageIndex] = PageData<T>(
        index: pageIndex,
        listItems: pageListItems,
        isLastPage: isLastPage,
      );
    }
  }
}
