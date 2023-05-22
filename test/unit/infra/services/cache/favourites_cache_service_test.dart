import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/managers/cache/cache_entry_key.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';
import 'package:miro/infra/repositories/cache/favourites_cache_repository.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/cache/favourites_cache_service_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();

  String actualHiveKey = CacheEntryKey.favourites.name;
  String actualConfigKey = 'test';

  late ICacheManager actualCacheManager;
  late FavouritesCacheRepository actualFavouritesCacheRepository;
  late FavouritesCacheService actualFavouritesCacheService;

  setUp(() {
    actualCacheManager = MemoryCacheManager();
    actualFavouritesCacheRepository = FavouritesCacheRepository(cacheManager: actualCacheManager);
    actualFavouritesCacheService = FavouritesCacheService(
      domainName: actualConfigKey,
      favouritesCacheRepository: actualFavouritesCacheRepository,
    );
  });

  group('Tests of FavouritesCacheService.add()', () {
    test('Should return [1 favourite element] after adding element to [EMPTY cache]', () async {
      // Act
      String actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedCacheValue = '';

      TestUtils.printInfo('Should return [empty string] if [favourites NOT exist]');
      expect(actualCacheValue, expectedCacheValue);

      // ********************************************************************************************************************

      // Act
      await actualFavouritesCacheService.add('test_id_1');
      actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedCacheValue = '["test_id_1"]';

      TestUtils.printInfo('Should return [List of Favourites] after adding element to empty cache');
      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should return [2 favourite elements] after adding element to [FILLED cache]', () async {
      // Arrange
      await actualCacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: '["test_id_1"]');

      // Act
      await actualFavouritesCacheService.add('test_id_2');
      String actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedCacheValue = '["test_id_1","test_id_2"]';

      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of FavouritesCacheService.delete()', () {
    test('Should [ignore delete] if [element NOT exist in cache]', () async {
      // Act
      String actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedCacheValue = '';

      TestUtils.printInfo('Should return [empty string] if [favourites NOT exist in cache]');
      expect(actualCacheValue, expectedCacheValue);

      // ********************************************************************************************************************

      // Act
      await actualFavouritesCacheService.delete('test_id_1');
      actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedCacheValue = '[]';

      TestUtils.printInfo('Should [ignore delete] if [element NOT exists in cache]');
      expect(actualCacheValue, expectedCacheValue);
    });

    test('Should [remove specified element] if [element exists in cache]', () async {
      // Arrange
      await actualCacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: '["test_id_1","test_id_2"]');

      // Act
      await actualFavouritesCacheService.delete('test_id_2');
      String actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedCacheValue = '["test_id_1"]';

      TestUtils.printInfo('Should [remove specified element] if [element exists]');
      expect(actualCacheValue, expectedCacheValue);

      // ********************************************************************************************************************

      await actualFavouritesCacheService.delete('test_id_1');
      actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedCacheValue = '[]';

      TestUtils.printInfo('Should return [empty list] after [last element removed]');
      expect(actualCacheValue, expectedCacheValue);
    });
  });

  group('Tests of FavouritesCacheService.getAll()', () {
    test('Should return [empty set] if [cache EMPTY]', () async {
      // Act
      String actualCacheValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedCacheValue = '';

      TestUtils.printInfo('Should return [empty string] if [favourites NOT exist in cache]');
      expect(actualCacheValue, expectedCacheValue);

      // ********************************************************************************************************************

      // Act
      Set<String> actualFavourites = actualFavouritesCacheService.getAll();

      // Assert
      Set<String> expectedFavourites = <String>{};

      expect(actualFavourites, expectedFavourites);
    });

    test('Should return [set of favourites] if [cache FILLED]', () async {
      // Arrange
      await actualCacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: '["test_id_1","test_id_2"]');

      // Act
      Set<String> actualFavourites = actualFavouritesCacheService.getAll();

      // Assert
      Set<String> expectedFavourites = <String>{'test_id_1', 'test_id_2'};

      expect(actualFavourites, expectedFavourites);
    });
  });
}
