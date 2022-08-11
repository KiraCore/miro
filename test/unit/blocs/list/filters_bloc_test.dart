import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/search_option.dart';
import 'package:miro/blocs/specific_blocs/list/filters/states/filters_empty_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_list_item.dart';
import 'mock_data/mock_list_item_filter_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/filters_bloc_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();
  await globalLocator<CacheManager>().init();

  group('Tests of FiltersBloc initial state', () {
    test('Should return FiltersEmptyState', () async {
      // Arrange
      FiltersBloc<MockListItem> actualFiltersBloc = FiltersBloc<MockListItem>(
        searchComparator: MockListItemFilterOptions.search,
      );

      // Assert
      FiltersEmptyState<MockListItem> expectedFiltersState = FiltersEmptyState<MockListItem>();

      expect(
        actualFiltersBloc.state,
        expectedFiltersState,
      );
    });
  });

  group('Tests of adding/removing filters process', () {
    test('Should return FiltersEmptyState or list of active filters', () async {
      // Arrange
      FiltersBloc<MockListItem> actualFiltersBloc = FiltersBloc<MockListItem>(
        searchComparator: MockListItemFilterOptions.search,
      );

      // Assert
      FiltersEmptyState<MockListItem> expectedFiltersState = FiltersEmptyState<MockListItem>();

      TestUtils.printInfo('Should return FiltersEmptyState');
      expect(
        actualFiltersBloc.state,
        expectedFiltersState,
      );

      // Act
      actualFiltersBloc.add(FiltersAddOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      List<FilterOption<MockListItem>> expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
      ];

      TestUtils.printInfo('Should add new filter option and return list with one filter option');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(FiltersAddOptionEvent<MockListItem>(MockListItemFilterOptions.filterByPaused));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
        MockListItemFilterOptions.filterByPaused,
      ];

      TestUtils.printInfo('Should add new filter option and return list with two filter options');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<MockListItem>('apple'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
        MockListItemFilterOptions.filterByPaused,
        SearchOption<MockListItem>(MockListItemFilterOptions.search('apple')),
      ];

      TestUtils.printInfo('Should add search filter option and return list with three filter options');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<MockListItem>(''));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
        MockListItemFilterOptions.filterByPaused,
      ];

      TestUtils.printInfo('Should remove search option if searchText is empty');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(const FiltersSearchEvent<MockListItem>('apple'));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
        MockListItemFilterOptions.filterByPaused,
        SearchOption<MockListItem>(MockListItemFilterOptions.search('apple')),
      ];

      TestUtils.printInfo('Should add search filter option and return list with three filter options');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<MockListItem>(
        SearchOption<MockListItem>(MockListItemFilterOptions.search('apple')),
      ));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByActive,
        MockListItemFilterOptions.filterByPaused,
      ];

      TestUtils.printInfo('Should remove search filter option and return list with two filter options');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<MockListItem>(MockListItemFilterOptions.filterByActive));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[
        MockListItemFilterOptions.filterByPaused,
      ];

      TestUtils.printInfo('Should remove filterByActive filter option and return list with one filter option');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );

      // Act
      actualFiltersBloc.add(FiltersRemoveOptionEvent<MockListItem>(MockListItemFilterOptions.filterByPaused));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFilterOptions = <FilterOption<MockListItem>>[];

      TestUtils.printInfo('Should remove filterByPaused filter option and return empty list');
      expect(
        actualFiltersBloc.state.activeFilters,
        expectedFilterOptions,
      );
    });
  });
}
