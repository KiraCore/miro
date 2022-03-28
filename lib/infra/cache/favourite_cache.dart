import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';

class FavouriteCache {
  final String boxName;
  final CacheManager _cacheManager = globalLocator<CacheManager>();

  FavouriteCache({
    required this.boxName,
  });

  bool get({required String id}) {
    return _cacheManager.get<bool>(boxName: boxName, key: id, defaultValue: false);
  }

  void add({required String id, required bool value}) {
    _cacheManager.add<bool>(boxName: boxName, key: id, value: value);
  }

  void delete({required String id}) {
    return _cacheManager.delete<bool>(boxName: boxName, key: id);
  }

  Map<String, bool> getAll() {
    return _cacheManager.getAll<bool>(boxName: boxName);
  }
}
