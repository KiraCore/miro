import 'package:flutter/cupertino.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';

class MemoryCacheManager implements ICacheManager {
  @visibleForTesting
  final Map<String, Map<String, dynamic>> cache = <String, Map<String, dynamic>>{};

  @override
  Future<void> init() async {}

  @override
  Future<void> add<T>({required String boxName, required String key, required T value}) async {
    cache.putIfAbsent(boxName, () => <String, dynamic>{});
    cache[boxName]![key] = value;
  }

  @override
  Future<void> delete<T>({required String boxName, required String key}) async {
    cache.putIfAbsent(boxName, () => <String, dynamic>{});
    cache[boxName]!.remove(key);
  }

  @override
  Future<void> deleteAll<T>({required String boxName}) async {
    cache.putIfAbsent(boxName, () => <String, dynamic>{});
    cache[boxName]!.clear();
  }

  @override
  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return cache[boxName]?[key] as T? ?? defaultValue;
  }

  @override
  Map<String, T> getAll<T>({required String boxName}) {
    return cache[boxName]?.map<String, T>((String key, dynamic value) => MapEntry<String, T>(key, value as T)) ?? <String, T>{};
  }
}
