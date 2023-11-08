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
import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/utils/list_utils.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class AListBloc<T extends AListItem> extends Bloc<AListEvent, AListState> {
  final AppConfig appConfig = globalLocator<AppConfig>();
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final PageReloadController pageReloadController = PageReloadController();

  final int singlePageSize;
  final IListController<T> listController;

  final FavouritesBloc<T>? favouritesBloc;
  final FiltersBloc<T>? filtersBloc;
  final SortBloc<T>? sortBloc;

  late StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;
  late StreamSubscription<AFavouritesState>? _favouritesStateSubscription;
  late StreamSubscription<AFiltersState<T>>? _filtersStateSubscription;
  late StreamSubscription<SortState<T>>? _sortStateSubscription;

  int lastPageIndex = 0;

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
    required this.singlePageSize,
    required this.listController,
    this.favouritesBloc,
    this.filtersBloc,
    this.sortBloc,
  }) : super(ListLoadingState()) {
    // Assign events to methods
    on<ListReloadEvent>(_mapListReloadEventToState);
    on<ListNextPageEvent>(_mapListNextPageEventToState);
    on<ListOptionsChangedEvent>(_mapListOptionsChangedEventToState);

    // Init listeners
    _favouritesStateSubscription = favouritesBloc?.stream.listen((_) => add(const ListUpdatedEvent(jumpToTop: true)));
    _filtersStateSubscription = filtersBloc?.stream.listen((_) => add(ListOptionsChangedEvent()));
    _networkModuleStateSubscription = networkModuleBloc.stream.listen(_reloadAfterNetworkModuleStateChanged);
    _sortStateSubscription = sortBloc?.stream.listen((_) => add(ListOptionsChangedEvent()));

    // Call ListReloadEvent to fetch first page
    add(ListReloadEvent());
  }

  @override
  Future<void> close() async {
    showLoadingOverlay.dispose();

    await _networkModuleStateSubscription.cancel();
    await _favouritesStateSubscription?.cancel();
    await _filtersStateSubscription?.cancel();
    await _sortStateSubscription?.cancel();
    return super.close();
  }

  List<T> sortList(List<T> listItems) {
    bool sortingDisabledBool = sortBloc == null;
    if (sortingDisabledBool) {
      return listItems;
    }
    SortOption<T> activeSortOption = sortBloc!.state.activeSortOption;
    List<T> favouritesList = favouritesBloc?.favouritesList ?? <T>[];
    Set<T> uniqueListItems = <T>{
      ...activeSortOption.sort(filterList(favouritesList.toSet().toList())),
      ...activeSortOption.sort(listItems),
    };
    return uniqueListItems.toList();
  }

  List<T> filterList(List<T> listItems) {
    bool filtersDisabledBool = filtersBloc?.state is! FiltersActiveState<T>;
    if (filtersDisabledBool) {
      return listItems;
    }
    FilterComparator<T> filterComparator = (filtersBloc!.state as FiltersActiveState<T>).filterComparator;
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
    lastPageIndex = 0;

    await favouritesBloc?.initFavourites();

    bool filtersEnabledBool = filtersBloc?.state is FiltersActiveState<T>;
    bool sortEnabledBool = sortBloc != null;

    if (filtersEnabledBool || sortEnabledBool || sortBloc?.isDefaultSortEnabled == false) {
      await _downloadAllListData(emit);
    }

    bool reloadActiveBool = pageReloadController.canReloadComplete(localReloadId) && isClosed == false;
    if (reloadActiveBool) {
      add(const ListNextPageEvent(afterReloadBool: true));
    }
  }

  Future<void> _mapListNextPageEventToState(ListNextPageEvent listNextPageEvent, Emitter<AListState> emit) async {
    int localReloadId = pageReloadController.activeReloadId;
    pageDownloadingStatus = true;
    try {
      PageData<T> pageData = await _getPageData(lastPageIndex);

      downloadedPagesCache[lastPageIndex] = pageData;
      currentPageData = pageData;

      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      bool isBlocActive = !isClosed;
      if (canReloadComplete && isBlocActive) {
        add(ListUpdatedEvent(jumpToTop: listNextPageEvent.afterReloadBool));
      }
    } catch (e) {
      AppLogger().log(message: 'Cannot fetch list data for page $lastPageIndex');
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete) {
        pageReloadController.hasErrors = true;
        emit(ListErrorState());
      }
    }
    pageDownloadingStatus = false;
  }

  Future<void> _mapListOptionsChangedEventToState(ListOptionsChangedEvent listOptionsChangedEvent, Emitter<AListState> emit) async {
    await _downloadAllListData(emit);
    add(const ListUpdatedEvent(jumpToTop: true));
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
      PageData<T> pageData = await listController.getPageData(PaginationDetailsModel(
        offset: offset,
        limit: singlePageSize,
      ));
      return pageData;
    }
  }

  Future<void> _downloadAllListData(Emitter<AListState> emit) async {
    bool lastPageBool = false;
    if (downloadedPagesCache.isNotEmpty) {
      PageData<T> lastPageData = downloadedPagesCache[downloadedPagesCache.keys.last]!;
      lastPageBool = lastPageData.lastPageBool;
    }
    if (lastPageBool) {
      return;
    }
    showLoadingOverlay.value = true;

    await Future<void>.delayed(const Duration(milliseconds: 500));
    List<PageData<T>> allListItems = List<PageData<T>>.empty(growable: true);
    int downloadedPagesCount = 0;
    int bulkSinglePageSize = appConfig.bulkSinglePageSize;

    try {
      await Future.doWhile(() async {
        int offset = downloadedPagesCount * bulkSinglePageSize;
        PageData<T> currentPageData = await listController.getPageData(PaginationDetailsModel(
          offset: offset,
          limit: bulkSinglePageSize,
        ));
        allListItems.add(currentPageData);
        downloadedPagesCount += 1;
        return currentPageData.lastPageBool == false;
      });
      _setupPagesCacheFromList(allListItems);
    } catch (_) {
      AppLogger().log(message: 'Cannot fetch all list data for ${listController.runtimeType}');
      pageReloadController.hasErrors = true;
      showLoadingOverlay.value = false;
      emit(ListErrorState());
      return;
    }

    if (isClosed == false) {
      showLoadingOverlay.value = false;
    }
  }

  void _setupPagesCacheFromList(List<PageData<T>> allPagesData) {
    List<T> allListItems = allPagesData.expand((PageData<T> pageData) => pageData.listItems).toList();

    for (int i = 0; i < allListItems.length; i += singlePageSize) {
      int pageIndex = i ~/ singlePageSize;
      List<T> pageListItems = ListUtils.getSafeSublist<T>(list: allListItems, start: i, end: i + singlePageSize);
      bool lastPageBool = i + singlePageSize >= allListItems.length - 1;
      downloadedPagesCache[pageIndex] = PageData<T>(
        listItems: pageListItems,
        lastPageBool: lastPageBool,
      );
    }
  }
}
