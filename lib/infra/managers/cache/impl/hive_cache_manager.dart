import 'package:hive/hive.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';

class HiveCacheManager extends ICacheManager {
  @override
  Future<void> init() async {
    await initHive();
  }

  @override
  Future<void> add<T>({required String boxName, required String key, required T value}) async {
    await Hive.box<T>(boxName).put(key, value);
  }

  @override
  Future<void> delete<T>({required String boxName, required String key}) async {
    await Hive.box<T>(boxName).delete(key);
  }

  @override
  Future<void> deleteAll<T>({required String boxName}) async {
    await Hive.box<T>(boxName).clear();
  }

  @override
  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return Hive.box<T>(boxName).get(key, defaultValue: defaultValue)!;
  }

  @override
  Map<String, T> getAll<T>({required String boxName}) {
    Map<dynamic, T> result = Hive.box<T>(boxName).toMap();
    if( result.isEmpty ) {
      return <String, T>{};
    } else {
      return result.map<String, T>((dynamic key, dynamic value) => MapEntry<String, T>(key.toString(), value as T));
    }
  }
}
