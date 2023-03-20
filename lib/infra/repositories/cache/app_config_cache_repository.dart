import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/cache_entry_box_name.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';

class AppConfigCacheRepository {
  static const CacheEntryBoxName _cacheEntryBoxName = CacheEntryBoxName.config;
  final ICacheManager _cacheManager;

  AppConfigCacheRepository({
    ICacheManager? cacheManager,
  }) : _cacheManager = cacheManager ?? globalLocator<ICacheManager>();

  String getLanguage({required String defaultValue}) {
    return _cacheManager.get<String>(boxName: _cacheEntryBoxName.name, key: 'language', defaultValue: defaultValue);
  }

  Future<void> setLanguage(String language) async {
    await _cacheManager.add<String>(boxName: _cacheEntryBoxName.name, key: 'language', value: language);
  }
}
