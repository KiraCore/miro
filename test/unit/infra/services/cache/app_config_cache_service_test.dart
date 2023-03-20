import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/cache_entry_box_name.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/services/cache/app_config_cache_service.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/cache/app_config_cache_service_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();

  String actualHiveKey = CacheEntryBoxName.config.name;
  String actualConfigKey = 'language';

  ICacheManager cacheManager = globalLocator<ICacheManager>();
  await cacheManager.init();

  AppConfigCacheService appConfigCacheService = AppConfigCacheService();
  await Hive.openBox<String>(actualHiveKey);

  group('Tests of AppConfigCacheService.getLanguage()', () {
    test('Should return [DEFAULT value] if [language NOT EXISTS in database]', () async {
      // Act
      String actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');
      String actualLanguage = appConfigCacheService.getLanguage(defaultValue: 'default');

      // Assert
      String expectedDatabaseValue = '';

      TestUtils.printInfo('Should return [EMPTY STRING] if [language NOT EXISTS in database] (database)');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // Assert
      String expectedLanguage = 'default';

      TestUtils.printInfo('Should return given [DEFAULT value] if [language NOT EXISTS in database] (service)');
      expect(actualLanguage, expectedLanguage);
    });

    test('Should return [DATABASE value] if [language EXISTS in database]', () async {
      // Arrange
      await cacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: 'en');

      // Act
      String actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');
      String actualLanguage = appConfigCacheService.getLanguage(defaultValue: 'default');

      // Assert
      String expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en](database)');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // Assert
      String expectedLanguage = 'en';

      TestUtils.printInfo('Should return [en] (service)');
      expect(actualLanguage, expectedLanguage);
    });
  });

  group('Tests of AppConfigCacheService.setLanguage()', () {
    test('Should [add language in database] if [language NOT EXISTS in database]', () async {
      // Arrange
      await cacheManager.delete<String>(boxName: actualHiveKey, key: actualConfigKey);

      // Act
      String actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedDatabaseValue = '';

      TestUtils.printInfo('Should return [empty string] if [language NOT EXISTS in database]');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // ********************************************************************************************************************

      // Act
      await appConfigCacheService.setLanguage('en');
      actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en]');
      expect(actualDatabaseValue, expectedDatabaseValue);
    });

    test('Should [update language in database] if [language NOT EXISTS in database]', () async {
      // Arrange
      await cacheManager.add<String>(boxName: actualHiveKey, key: actualConfigKey, value: 'en');

      // Act
      String actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      String expectedDatabaseValue = 'en';

      TestUtils.printInfo('Should return [en]');
      expect(actualDatabaseValue, expectedDatabaseValue);

      // ********************************************************************************************************************

      // Act
      await appConfigCacheService.setLanguage('pl');
      actualDatabaseValue = cacheManager.get<String>(boxName: actualHiveKey, key: actualConfigKey, defaultValue: '');

      // Assert
      expectedDatabaseValue = 'pl';

      TestUtils.printInfo('Should return [pl]');
      expect(actualDatabaseValue, expectedDatabaseValue);
    });
  });
}
