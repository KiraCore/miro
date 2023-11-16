import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loading_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_next_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/events/paginated_list_previous_page_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/states/paginated_list_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/events/sort_clear_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_list_controller.dart';
import 'mock_data/mock_list_item.dart';
import 'mock_data/mock_list_item_filter_options.dart';
import 'mock_data/mock_list_item_sort_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/kira/kira_list/paginated_list_bloc_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  MockListItem expectedMockListItem1 = MockListItem(id: 1, name: 'apple', status: 'active');
  MockListItem expectedMockListItem2 = MockListItem(id: 2, name: 'banana', status: 'active');
  MockListItem expectedMockListItem3 = MockListItem(id: 3, name: 'coconut', status: 'paused');

  group('Tests of [PaginatedListBloc] initial state', () {
    test('Should return [ListLoadingState] as initial [PaginatedListBloc] state ', () {
      // Arrange
      MockListController actualMockListController = MockListController();
      PaginatedListBloc<MockListItem> actualPaginatedListBloc = PaginatedListBloc<MockListItem>(
        singlePageSize: 2,
        listController: actualMockListController,
      );

      // Act
      AListState actualListState = actualPaginatedListBloc.state;

      // Assert
      AListState expectedListState = ListLoadingState();
      expect(actualListState, expectedListState);
    });
  });

  group('Tests of [PaginatedListBloc] process', () {
    test('Should return [AListState] assigned to specified events', () async {
      // Arrange
      MockListController actualMockListController = MockListController();
      FiltersBloc<MockListItem> actualFiltersBloc = FiltersBloc<MockListItem>(
        searchComparator: MockListItemFilterOptions.search,
      );
      SortBloc<MockListItem> actualSortBloc = SortBloc<MockListItem>(
        defaultSortOption: MockListItemSortOptions.sortById,
      );
      FavouritesBloc<MockListItem> actualFavouritesBloc = FavouritesBloc<MockListItem>(
        listController: actualMockListController,
      );
      PaginatedListBloc<MockListItem> actualPaginatedListBloc = PaginatedListBloc<MockListItem>(
        singlePageSize: 2,
        listController: actualMockListController,
        favouritesBloc: actualFavouritesBloc,
        filterBloc: actualFiltersBloc,
        sortBloc: actualSortBloc,
      );

      // Assert
      AListState expectedListState = ListLoadingState();

      TestUtils.printInfo('Should return [ListLoadingState] as initial state');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with first page of items. [with default sort option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualPaginatedListBloc.add(PaginatedListNextPageEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3],
        lastPageBool: true,
        pageIndex: 1,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with last page of items. [with default sort option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualPaginatedListBloc.add(PaginatedListPreviousPageEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with first page of items. [with default sort option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should [set "sortById"] and return [PaginatedListLoadedState] with first page of sorted items');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualPaginatedListBloc.add(PaginatedListNextPageEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1],
        lastPageBool: true,
        pageIndex: 1,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );
      TestUtils.printInfo('Should return [PaginatedListLoadedState] with last page of items. [with "sortById" option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualSortBloc.add(SortClearEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should clear sort options and return [PaginatedListLoadedState] with first page of items. [with default sort option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualFiltersBloc.add(FiltersAddOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should [set "filterByActive"] and return [PaginatedListLoadedState] with first page of items that match filters');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortById.reversed()));
      await Future<void>.delayed(const Duration(milliseconds: 600));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem2, expectedMockListItem1],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should [set "sortById"] and return [PaginatedListLoadedState] with first page of sorted items that match "filterByActive" filter');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualPaginatedListBloc.add(PaginatedListNextPageEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: const <MockListItem>[],
        lastPageBool: true,
        pageIndex: 1,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with no elements if next page is empty and last page was not recognized');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3, expectedMockListItem2],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should [remove "filterByActive"] and return [PaginatedListLoadedState] with first page of items [with "sortById" option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<MockListItem>(expectedMockListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem1, expectedMockListItem3],
        lastPageBool: false,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with list of items containing favourites first [with "sortById" option]');
      expect(actualPaginatedListBloc.state, expectedListState);

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<MockListItem>('coco'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedListState = PaginatedListLoadedState<MockListItem>(
        listItems: <MockListItem>[expectedMockListItem3],
        lastPageBool: true,
        pageIndex: 0,
        blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
        cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
      );

      TestUtils.printInfo('Should return [PaginatedListLoadedState] with first page of items that match search query ("coco") [with "sortById" option]');
      expect(actualPaginatedListBloc.state, expectedListState);
    });
  });
}
