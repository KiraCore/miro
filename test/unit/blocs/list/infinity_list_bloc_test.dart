import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loaded_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/states/list_loading_state.dart';
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
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_list_controller.dart';
import 'mock_data/mock_list_item.dart';
import 'mock_data/mock_list_item_filter_options.dart';
import 'mock_data/mock_list_item_sort_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/infinity_list_bloc_test.dart --platform chrome
Future<void> main() async {
  await initMockLocator();
  await globalLocator<CacheManager>().init();

  MockListItem expectedMockListItem1 = MockListItem(id: 1, name: 'apple', status: 'active');
  MockListItem expectedMockListItem2 = MockListItem(id: 2, name: 'banana', status: 'active');
  MockListItem expectedMockListItem3 = MockListItem(id: 3, name: 'coconut', status: 'paused');

  group('Tests of initial list state', () {
    test('Should return ListLoadingState as initial state', () async {
      // Arrange
      MockListController mockListController = MockListController();
      FiltersBloc<MockListItem> actualFiltersBloc = FiltersBloc<MockListItem>(
        searchComparator: MockListItemFilterOptions.search,
      );
      SortBloc<MockListItem> actualSortBloc = SortBloc<MockListItem>(
        defaultSortOption: MockListItemSortOptions.sortById,
      );
      FavouritesBloc<MockListItem> actualFavouritesBloc = FavouritesBloc<MockListItem>(
        listController: mockListController,
      );
      InfinityListBloc<MockListItem> actualInfinityListBloc = InfinityListBloc<MockListItem>(
        listController: mockListController,
        favouritesBloc: actualFavouritesBloc,
        filterBloc: actualFiltersBloc,
        sortBloc: actualSortBloc,
        singlePageSize: 2,
      );

      // Assert
      AListState expectedListState = ListLoadingState();
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );
    });
  });

  group('Tests of InfinityListBloc process', () {
    test('Should return AListState assigned to specified events', () async {
      MockListController mockListController = MockListController();
      FiltersBloc<MockListItem> actualFiltersBloc = FiltersBloc<MockListItem>(
        searchComparator: MockListItemFilterOptions.search,
      );
      SortBloc<MockListItem> actualSortBloc = SortBloc<MockListItem>(
        defaultSortOption: MockListItemSortOptions.sortById,
      );
      FavouritesBloc<MockListItem> actualFavouritesBloc = FavouritesBloc<MockListItem>(
        listController: mockListController,
      );
      InfinityListBloc<MockListItem> actualInfinityListBloc = InfinityListBloc<MockListItem>(
        listController: mockListController,
        filterBloc: actualFiltersBloc,
        sortBloc: actualSortBloc,
        favouritesBloc: actualFavouritesBloc,
        singlePageSize: 2,
      );

      // Assert
      AListState expectedListState = ListLoadingState();

      TestUtils.printInfo('Should return ListLoadingState as initial state');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPage: false,
      );

      TestUtils.printInfo('Should return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2, expectedMockListItem3],
        lastPage: true,
      );

      TestUtils.printInfo('Should return ListLoadedState with first and second pages of list items (second page is last page)');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3, expectedMockListItem2],
        lastPage: false,
      );

      TestUtils.printInfo('Should reverse sort order and return ListLoadedState with sorted first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3, expectedMockListItem2, expectedMockListItem1],
        lastPage: true,
      );

      TestUtils.printInfo('Should fetch next page and return ListLoadedState with sorted first and second pages of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortClearEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPage: false,
      );

      TestUtils.printInfo('Should clear filters and return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(FiltersAddOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPage: false,
      );

      TestUtils.printInfo('Should add filterByActive filter and return ListLoadedState with first page of list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem2, expectedMockListItem1],
        lastPage: false,
      );

      TestUtils.printInfo('Should return ListLoadedState with first page of sorted list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualInfinityListBloc.add(InfinityListReachedBottomEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem2, expectedMockListItem1],
        lastPage: true,
      );

      TestUtils.printInfo('Should return ListLoadedState with first and second page of sorted list items that match filters');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3, expectedMockListItem2],
        lastPage: false,
      );

      TestUtils.printInfo('Should remove filterByActive filter option and return ListLoadedState with first page of list items');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<MockListItem>(expectedMockListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem3],
        lastPage: false,
      );

      TestUtils.printInfo('Should return ListLoadedState with list of list items containing favourites first ');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<MockListItem>('coco'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = ListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3],
        lastPage: true,
      );

      TestUtils.printInfo('Should return ListLoadedState with first page pf list items that match search query');
      expect(
        actualInfinityListBloc.state,
        expectedListState,
      );
    });
  });
}
