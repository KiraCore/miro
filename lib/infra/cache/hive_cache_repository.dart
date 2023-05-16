import 'package:hive/hive.dart';
import 'package:miro/infra/cache/a_cache_repository.dart';

class HiveCacheRepository extends ACacheRepository {
  @override
  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return Hive.box<T>(boxName).get(
      key,
      defaultValue: defaultValue,
    )!;
  }

  @override
  Map<String, T> getAll<T>({required String boxName}) {
    return Hive.box<T>(boxName).toMap() as Map<String, T>;
  }

  @override
  void add<T>({required String boxName, required String key, required T value}) {
    Hive.box<T>(boxName).put(
      key,
      value,
    );
  }

  @override
  void delete<T>({required String boxName, required String key}) {
    Hive.box<T>(boxName).delete(key);
  }
}