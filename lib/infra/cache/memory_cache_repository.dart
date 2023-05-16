import 'package:miro/infra/cache/a_cache_repository.dart';

class MemoryCacheRepository extends ACacheRepository {
  final Map<String, Map<String, dynamic>> _cache = <String, Map<String, dynamic>>{};

  @override
  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return _cache[boxName]?[key] as T? ?? defaultValue;
  }

  @override
  Map<String, T> getAll<T>({required String boxName}) {
    return _cache[boxName]?.map<String, T>((String key, dynamic value) => MapEntry<String, T>(key, value as T)) ??
        <String, T>{};
  }

  @override
  void add<T>({required String boxName, required String key, required T value}) {
    _cache.putIfAbsent(boxName, () => <String, dynamic>{});
    _cache[boxName]![key] = value;
  }

  @override
  void delete<T>({required String boxName, required String key}) {
    _cache.putIfAbsent(boxName, () => <String, dynamic>{});
    _cache[boxName]!.remove(key);
  }
}