import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_clear_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'test_data/test_list_item.dart';
import 'test_data/test_list_item_sort_options.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/sort_bloc_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  group('Tests of SortBloc initial state', () {
    test('Should return SortState with default sort option', () async {
      // Arrange
      SortBloc<TestListItem> actualSortBloc = SortBloc<TestListItem>(
        defaultSortOption: TestListItemSortOptions.sortById,
      );

      // Assert
      SortState<TestListItem> expectedSortState = SortState<TestListItem>(TestListItemSortOptions.sortById);
      expect(
        actualSortBloc.state,
        expectedSortState,
      );
    });
  });

  group('Tests of sort process', () {
    test('Should return SortState assigned to specified events', () async {
      // Arrange
      SortBloc<TestListItem> actualSortBloc = SortBloc<TestListItem>(
        defaultSortOption: TestListItemSortOptions.sortById,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<TestListItem>(sortOption: TestListItemSortOptions.sortByName));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      SortState<TestListItem> expectedSortState = SortState<TestListItem>(TestListItemSortOptions.sortByName);

      testPrint('Should return SortState with sortByName sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<TestListItem>(sortOption: TestListItemSortOptions.sortById));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<TestListItem>(TestListItemSortOptions.sortById);

      testPrint('Should return SortState with sortById sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortChangeEvent<TestListItem>(sortOption: TestListItemSortOptions.sortByStatus));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<TestListItem>(TestListItemSortOptions.sortByStatus);

      testPrint('Should return SortState with sortByStatus sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );

      // Act
      actualSortBloc.add(SortClearEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSortState = SortState<TestListItem>(TestListItemSortOptions.sortById);

      testPrint('Should return SortState with default sortById sort option');
      expect(
        actualSortBloc.state,
        expectedSortState,
      );
    });
  });
}
