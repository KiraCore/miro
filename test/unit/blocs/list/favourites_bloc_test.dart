import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/states/favourites_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'test_data/test_list_controller.dart';
import 'test_data/test_list_item.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/favourites_bloc_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  TestListItem expectedTestListItem1 = TestListItem(id: 1, name: 'apple', status: 'active');
  TestListItem expectedTestListItem2 = TestListItem(id: 2, name: 'banana', status: 'active');

  group('Tests of FavouritesBloc initial state', () {
    test('Should return FavouritesLoadedState with empty favouritesList', () async {
      // Arrange
      TestListController actualTestListController = TestListController();
      FavouritesBloc<TestListItem> actualFavouritesBloc = FavouritesBloc<TestListItem>(
        listController: actualTestListController,
      );

      // Act
      await actualFavouritesBloc.initFavourites();

      // Assert
      FavouritesLoadedState<TestListItem> expectedFavouritesState = const FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[],
      );

      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );
    });
  });

  group('Tests of adding/removing favourites process', () {
    test('Should return FavouritesLoadedState with actual favourites list', () async {
      // Arrange
      TestListController actualTestListController = TestListController();
      FavouritesBloc<TestListItem> actualFavouritesBloc = FavouritesBloc<TestListItem>(
        listController: actualTestListController,
      );

      // Act
      await actualFavouritesBloc.initFavourites();

      // Assert
      FavouritesLoadedState<TestListItem> expectedFavouritesState = const FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[],
      );

      testPrint('Should return FavouritesLoadedState with empty favourites list');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<TestListItem>(expectedTestListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[expectedTestListItem1],
      );

      testPrint('Should add new favourite and return FavouritesLoadedState containing list with one favourite');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<TestListItem>(expectedTestListItem2));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[expectedTestListItem1, expectedTestListItem2],
      );

      testPrint('Should add new favourite and return FavouritesLoadedState containing list with two favourites');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesRemoveRecordEvent<TestListItem>(expectedTestListItem2));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[expectedTestListItem1],
      );

      testPrint('Should remove new favourite and return FavouritesLoadedState containing list with one favourite');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesRemoveRecordEvent<TestListItem>(expectedTestListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = const FavouritesLoadedState<TestListItem>(
        favourites: <TestListItem>[],
      );

      testPrint('Should remove last favourite and return FavouritesLoadedState with empty list');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );
    });
  });
}
