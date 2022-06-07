import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_disconnected_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/events/infinity_list_reached_bottom_event.dart';
import 'package:miro/blocs/specific_blocs/list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_clear_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'test_data/test_list_controller.dart';
import 'test_data/test_list_item.dart';
import 'test_data/test_list_item_filter_options.dart';
import 'test_data/test_list_item_sort_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/infinity_list_bloc_test.dart --platform chrome
Future<void> main() async {
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  final NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.connected,
    name: 'https://unhealthy.kira.network',
    uri: Uri.parse('https://unhealthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: '0.0.1',
      latestBlockHeight: 123,
      latestBlockTime: DateTime.now(),
      activeValidators: 1,
      totalValidators: 1,
    ),
  );

  TestListItem expectedTestListItem1 = TestListItem(id: 1, name: 'apple', status: 'active');
  TestListItem expectedTestListItem2 = TestListItem(id: 2, name: 'banana', status: 'active');
  TestListItem expectedTestListItem3 = TestListItem(id: 3, name: 'coconut', status: 'paused');

  group('Tests of initial list state', () {
    test('Should return ListDisconnectedState if interx is not connected', () async {
      // Arrange
      TestListController testListController = TestListController();
      FiltersBloc<TestListItem> actualFiltersBloc = FiltersBloc<TestListItem>(
        searchComparator: TestListItemFilterOptions.search,
      );
      SortBloc<TestListItem> actualSortBloc = SortBloc<TestListItem>(
        defaultSortOption: TestListItemSortOptions.sortById,
      );
      FavouritesBloc<TestListItem> actualFavouritesBloc = FavouritesBloc<TestListItem>(
        listController: testListController,
      );
      InfinityListBloc<TestListItem> actualInfinityListBloc = InfinityListBloc<TestListItem>(
        listController: testListController,
        filterBloc: actualFiltersBloc,
        sortBloc: actualSortBloc,
        favouritesBloc: actualFavouritesBloc,
        singlePageSize: 2,
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      AListState expectedListState = ListDisconnectedState();
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );
    });
  });

  group('Tests of infinity list process', () {
    test('Should return AListState assigned to specified events', () async {
      // Arrange
      TestListController testListController = TestListController();
      FiltersBloc<TestListItem> actualFiltersBloc = FiltersBloc<TestListItem>(
        searchComparator: TestListItemFilterOptions.search,
      );
      SortBloc<TestListItem> actualSortBloc = SortBloc<TestListItem>(
        defaultSortOption: TestListItemSortOptions.sortById,
      );
      FavouritesBloc<TestListItem> actualFavouritesBloc = FavouritesBloc<TestListItem>(
        listController: testListController,
      );
      InfinityListBloc<TestListItem> actualInfinityListBloc = InfinityListBloc<TestListItem>(
        listController: testListController,
        filterBloc: actualFiltersBloc,
        sortBloc: actualSortBloc,
        favouritesBloc: actualFavouritesBloc,
        singlePageSize: 2,
      );

      // Assert
      await Future<void>.delayed(const Duration(milliseconds: 100));
      AListState expectedListState = ListDisconnectedState();

      testPrint('Should return ListDisconnectedState if network not connected');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem1, expectedTestListItem2],
        lastPage: false,
      );

      testPrint('Should return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem1, expectedTestListItem2, expectedTestListItem3],
        lastPage: true,
      );

      testPrint('Should return ListLoadedState with first and second pages of list items (second page is last page)');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<TestListItem>(sortOption: TestListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem3, expectedTestListItem2],
        lastPage: false,
      );

      testPrint('Should reverse sort order and return ListLoadedState with sorted first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem3, expectedTestListItem2, expectedTestListItem1],
        lastPage: true,
      );

      testPrint('Should fetch next page and return ListLoadedState with sorted first and second pages of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortClearEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem1, expectedTestListItem2],
        lastPage: false,
      );

      testPrint('Should clear filters and return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(FiltersAddOptionEvent<TestListItem>(TestListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem1, expectedTestListItem2],
        lastPage: false,
      );

      testPrint('Should add filterByActive filter and return ListLoadedState with first page of list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<TestListItem>(sortOption: TestListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem2, expectedTestListItem1],
        lastPage: false,
      );

      testPrint('Should return ListLoadedState with first page of sorted list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem2, expectedTestListItem1],
        lastPage: true,
      );

      testPrint('Should return ListLoadedState with first and second page of sorted list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<TestListItem>(TestListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem3, expectedTestListItem2],
        lastPage: false,
      );

      testPrint('Should remove filterByActive filter option and return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<TestListItem>(expectedTestListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem1, expectedTestListItem3],
        lastPage: false,
      );

      testPrint('Should return ListLoadedState with list of list items containing favourites first ');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<TestListItem>('coco'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<TestListItem>(
        listItems: <TestListItem>[expectedTestListItem3],
        lastPage: true,
      );

      testPrint('Should return ListLoadedState with first page pf list items that match search query');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );
    });
  });
}
