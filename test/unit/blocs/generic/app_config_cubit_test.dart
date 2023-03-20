import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/app_config/app_config_cubit.dart';
import 'package:miro/blocs/generic/app_config/app_config_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/cache_entry_box_name.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/services/cache/app_config_cache_service.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/app_config_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await globalLocator<ICacheManager>().init();

  group('Tests of AppConfigCubit initial and updated states', () {
    test('Should return default locale, then update language and return updated locale', () async {
      // Arrange
      CacheEntryBoxName cacheEntryKey = CacheEntryBoxName.config;
      AppConfigCubit actualAppConfigCubit = globalLocator<AppConfigCubit>();
      AppConfigCacheService actualAppConfigCacheService = actualAppConfigCubit.appConfigCacheService;

      // Assert
      AppConfigState expectedAppConfigState = const AppConfigState(locale: 'en');

      TestUtils.printInfo('Should return AppConfigState with "en" locale as initial state');
      expect(actualAppConfigCubit.state, expectedAppConfigState);

      // Act
      String actualSavedLocale = actualAppConfigCacheService.getLanguage(defaultValue: 'en');

      // Assert
      String expectedSavedLocale = globalLocator<ICacheManager>().get<String>(
        boxName: cacheEntryKey.name,
        key: 'language',
        defaultValue: 'en',
      );

      TestUtils.printInfo('Should return "en" locale from cache as default locale');
      expect(actualSavedLocale, expectedSavedLocale);

      // ************************************************************************************************

      // Act
      await actualAppConfigCubit.updateLang('pl');

      // Assert
      expectedAppConfigState = const AppConfigState(locale: 'pl');

      TestUtils.printInfo('Should return AppConfigState with "pl" locale ');
      expect(actualAppConfigCubit.state, expectedAppConfigState);

      // Act
      actualSavedLocale = actualAppConfigCacheService.getLanguage(defaultValue: 'en');

      // Assert
      expectedSavedLocale = globalLocator<ICacheManager>().get<String>(
        boxName: cacheEntryKey.name,
        key: 'language',
        defaultValue: 'en',
      );

      TestUtils.printInfo('Should return "en" locale from cache as default locale, despite previous changing to "pl"');
      expect(actualSavedLocale, expectedSavedLocale);
    });
  });
}
