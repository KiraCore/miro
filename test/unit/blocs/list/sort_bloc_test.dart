import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_clear_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_list_item.dart';
import 'mock_data/mock_list_item_sort_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/sort_bloc_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();
  await globalLocator<CacheManager>().init();

  group('Tests of SortBloc initial state', () {
    test('Should return SortState with default sort option', () async {
      // Arrange
      SortBloc<MockListItem> actualSortBloc = SortBloc<MockListItem>(
        defaultSortOption: MockListItemSortOptions.sortById,
      );

      // Assert
      SortState<MockListItem> expectedSortState = SortState<MockListItem>(MockListItemSortOptions.sortById);
      expect(
        actualSortBloc.state,
        expectedSortState,
      );
    });
  });

  group('Tests of sort process', () {
    test('Should return SortState assigned to specified events', () async {
      // Arrange
      SortBloc<MockListItem> actualSortBloc = SortBloc<MockListItem>(
        defaultSortOption: MockListItemSortOptions.sortById,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortByName));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      SortState<MockListItem> expectedSortState = SortState<MockListItem>(MockListItemSortOptions.sortByName);

      TestUtils.printInfo('Should return SortState with sortByName sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortById));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<MockListItem>(MockListItemSortOptions.sortById);

      TestUtils.printInfo('Should return SortState with sortById sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<MockListItem>(sortOption: MockListItemSortOptions.sortByStatus));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<MockListItem>(MockListItemSortOptions.sortByStatus);

      TestUtils.printInfo('Should return SortState with sortByStatus sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortClearEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<MockListItem>(MockListItemSortOptions.sortById);

      TestUtils.printInfo('Should return SortState with default sortById sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );
    });
  });
}
