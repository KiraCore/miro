import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/managers/cache/cache_entry_box_name.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';
import 'package:miro/infra/repositories/cache/app_config_cache_repository.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/repositories/cache/app_config_cache_repository_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();

  String actualHiveKey = CacheEntryBoxName.config.name;
  String actualConfigKey = 'language';

  late ICacheManager actualCacheManager;
  late AppConfigCacheRepository actualAppConfigCacheRepository;

  setUp(() {
    actualCacheManager = MemoryCacheManager();
    actualAppConfigCacheRepository = AppConfigCacheRepository(
      cacheManager: actualCacheManager,
    );
  });

  group('Tests of AppConfigCacheRepository.getLanguage()', () {
    test('Should return [DEFAULT value] if [language NOT EXISTS in database]', () async {
      // Act
      String actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');
      String actualLanguage = actualAppConfigCacheRepository.getLanguage(defaultValue: 'default');

      // Assert
      String expectedDatabaseValue = '';

      TestUtils.printInfo('Should return [EMPTY STRING] if [language NOT EXISTS in database] (database)');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // Assert
      String expectedLanguage = 'default';

      TestUtils.printInfo('Should return given [DEFAULT value] if [language NOT EXISTS in database] (repository)');
      expect(actualLanguage, expectedLanguage);
    });

    test('Should return [DATABASE value] if [language EXISTS in database]', () async {
      // Arrange
      await actualCacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: 'en');

      // Act
      String actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');
      String actualLanguage = actualAppConfigCacheRepository.getLanguage(defaultValue: 'default');

      // Assert
      String expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en](database)');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // Assert
      String expectedLanguage = 'en';

      TestUtils.printInfo('Should return [en] (repository)');
      expect(actualLanguage, expectedLanguage);
    });
  });

  group('Tests of AppConfigCacheRepository.setLanguage()', () {
    test('Should [add language in database] if [language NOT EXISTS in database]', () async {
      // Arrange
     await actualCacheManager.delete<String>(boxName: actualHiveKey, key: actualConfigKey);

      // Act
      String actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedDatabaseValue = '';

      TestUtils.printInfo('Should return [empty string] if [language NOT EXISTS in database]');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // ********************************************************************************************************************

      // Act
      await actualAppConfigCacheRepository.setLanguage('en');
      actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en]');
      expect(actualDatabaseValue, expectedDatabaseValue);
    });

    test('Should [update language in database] if [language NOT EXISTS in database]', () async {
      // Arrange
      await actualCacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: 'en');

      // Act
      String actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en]');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // ********************************************************************************************************************

      // Act
      await actualAppConfigCacheRepository.setLanguage('pl');
      actualDatabaseValue = actualCacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedDatabaseValue = 'pl';

      TestUtils.printInfo('Should return [pl]');
      expect(actualDatabaseValue, expectedDatabaseValue);
    });
  });
}
