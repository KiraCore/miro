import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/states/favourites_loaded_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

import 'mock_data/mock_list_controller.dart';
import 'mock_data/mock_list_item.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/list/favourites_bloc_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();
  await globalLocator<CacheManager>().init();

  MockListItem expectedMockListItem1 = MockListItem(id: 1, name: 'apple', status: 'active');
  MockListItem expectedMockListItem2 = MockListItem(id: 2, name: 'banana', status: 'active');

  group('Tests of FavouritesBloc initial state', () {
    test('Should return FavouritesLoadedState with empty favouritesList', () async {
      // Arrange
      MockListController actualMockListController = MockListController();
      FavouritesBloc<MockListItem> actualFavouritesBloc = FavouritesBloc<MockListItem>(
        listController: actualMockListController,
      );

      // Act
      await actualFavouritesBloc.initFavourites();

      // Assert
      FavouritesLoadedState<MockListItem> expectedFavouritesState = const FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[],
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
      MockListController actualMockListController = MockListController();
      FavouritesBloc<MockListItem> actualFavouritesBloc = FavouritesBloc<MockListItem>(
        listController: actualMockListController,
      );

      // Act
      await actualFavouritesBloc.initFavourites();

      // Assert
      FavouritesLoadedState<MockListItem> expectedFavouritesState = const FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[],
      );

      TestUtils.printInfo('Should return FavouritesLoadedState with empty favourites list');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<MockListItem>(expectedMockListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[expectedMockListItem1],
      );

      TestUtils.printInfo('Should add new favourite and return FavouritesLoadedState containing list with one favourite');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesAddRecordEvent<MockListItem>(expectedMockListItem2));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[expectedMockListItem1, expectedMockListItem2],
      );

      TestUtils.printInfo('Should add new favourite and return FavouritesLoadedState containing list with two favourites');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesRemoveRecordEvent<MockListItem>(expectedMockListItem2));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[expectedMockListItem1],
      );

      TestUtils.printInfo('Should remove new favourite and return FavouritesLoadedState containing list with one favourite');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );

      // Act
      actualFavouritesBloc.add(FavouritesRemoveRecordEvent<MockListItem>(expectedMockListItem1));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedFavouritesState = const FavouritesLoadedState<MockListItem>(
        favourites: <MockListItem>[],
      );

      TestUtils.printInfo('Should remove last favourite and return FavouritesLoadedState with empty list');
      expect(
        actualFavouritesBloc.state,
        expectedFavouritesState,
      );
    });
  });
}
