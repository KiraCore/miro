import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/cache/favourites_cache_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  group('Tests of add() method', () {
    test('Should return json encoded array with one favourite object', () async {
      // Arrange
      String cacheKey = 'test_add_1';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '["uniqueValue1"]';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return json encoded array with three favourite objects', () async {
      // Arrange
      String cacheKey = 'test_add_2';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '["uniqueValue1","uniqueValue2","uniqueValue3"]';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return unique favourites list array', () async {
      // Arrange
      String cacheKey = 'test_add_3';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');
      actualFavouriteCache.add('uniqueValue3');

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '["uniqueValue1","uniqueValue2","uniqueValue3"]';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of delete() method', () {
    test('Should return json encoded array without one deleted item', () async {
      // Arrange
      String cacheKey = 'test_delete_1';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');
      actualFavouriteCache.delete('uniqueValue3');

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '["uniqueValue1","uniqueValue2"]';

      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return json encoded array without three deleted items', () async {
      // Arrange
      String cacheKey = 'test_delete_2';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');
      actualFavouriteCache.delete('uniqueValue3');
      actualFavouriteCache.delete('uniqueValue2');
      actualFavouriteCache.delete('uniqueValue1');

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '[]';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of getAll() method', () {
    test('Should return array with three items', () async {
      // Arrange
      String cacheKey = 'test_all_1';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');

      // Assert
      List<String> expectedUniqueValues = <String>['uniqueValue1', 'uniqueValue2', 'uniqueValue3'];

      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );
    });

    test('Should return array with unique items', () async {
      // Arrange
      String cacheKey = 'test_all_2';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Act
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue1');
      actualFavouriteCache.add('uniqueValue2');
      actualFavouriteCache.add('uniqueValue3');
      actualFavouriteCache.add('uniqueValue3');

      // Assert
      List<String> expectedUniqueValues = <String>['uniqueValue1', 'uniqueValue2', 'uniqueValue3'];

      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );
    });

    test('Should return empty array if favourites not set', () async {
      // Arrange
      String cacheKey = 'test_all_3';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Assert
      List<String> expectedUniqueValues = <String>[];

      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );
    });
  });

  group('Tests of adding/removing favourites process', () {
    test('Should return actual favourites list', () {
      // Arrange
      String cacheKey = 'favourites_test';
      FavouriteCache actualFavouriteCache = FavouriteCache(key: cacheKey);

      // Assert
      String actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      String expectedCacheValue = '';

      testPrint('Should return empty String if favourites are not initialized');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      Set<String> expectedUniqueValues = <String>{};

      testPrint('Should return empty List if favourites are not initialized');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.add('uniqueValue1');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '["uniqueValue1"]';

      testPrint('Should add favourite item to cache and return actual favourites as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{'uniqueValue1'};

      testPrint('Should add favourite item to cache and return actual favourites as Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.add('uniqueValue2');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '["uniqueValue1","uniqueValue2"]';

      testPrint('Should add favourite item to cache and return actual favourites as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{'uniqueValue1', 'uniqueValue2'};

      testPrint('Should add favourite item to cache and return actual favourites as Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.add('uniqueValue2');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '["uniqueValue1","uniqueValue2"]';

      testPrint('Should ignore adding favourite item if item is liked already and return actual favourites as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{'uniqueValue1', 'uniqueValue2'};

      testPrint('Should ignore adding favourite item if item is liked already and return actual favourites as Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.delete('uniqueValue2');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '["uniqueValue1"]';

      testPrint('Should delete favourite item from cache and return actual favourites as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{'uniqueValue1'};

      testPrint('Should delete favourite item from cache and return actual favourites as Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.delete('uniqueValue2');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '["uniqueValue1"]';

      testPrint(
          'Should ignore removing favourite item if item not exists in favourites and return actual favourites as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{'uniqueValue1'};

      testPrint(
          'Should ignore removing favourite item if item not exists in favourites and return actual favourites as Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );

      // Act
      actualFavouriteCache.delete('uniqueValue1');

      // Assert
      actualCacheValue = globalLocator<CacheManager>().get<String>(
        boxName: FavouriteCache.hiveKey,
        key: cacheKey,
        defaultValue: '',
      );
      expectedCacheValue = '[]';

      testPrint('Should delete favourite item from cache and return empty list as String');
      expect(actualCacheValue, expectedCacheValue);

      // Assert
      expectedUniqueValues = <String>{};

      testPrint('Should delete favourite item from cache and return empty Set');
      expect(
        actualFavouriteCache.getAll(),
        expectedUniqueValues,
      );
    });
  });
}
