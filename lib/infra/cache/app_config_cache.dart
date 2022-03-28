import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';

class AppConfigCache {
  final String boxName = 'configuration';
  final CacheManager _cacheManager = globalLocator<CacheManager>();

  String getConfig(String key, {String? defaultValue}) {
    return _cacheManager.get<String>(boxName: boxName, key: key, defaultValue: defaultValue ?? '');
  }

  void updateConfig(String key, String? value) {
    if (value == null) {
      _cacheManager.delete<String>(boxName: boxName, key: key);
    } else {
      _cacheManager.add<String>(boxName: boxName, key: key, value: value);
    }
  }
}
