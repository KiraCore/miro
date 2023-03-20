import 'package:miro/infra/repositories/cache/app_config_cache_repository.dart';

class AppConfigCacheService {
  final AppConfigCacheRepository _appConfigCacheRepository = AppConfigCacheRepository();

  String getLanguage({required String defaultValue}) {
    return _appConfigCacheRepository.getLanguage(defaultValue: defaultValue);
  }

  Future<void> setLanguage(String language) async {
    await _appConfigCacheRepository.setLanguage(language);
  }
}
