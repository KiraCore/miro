import 'package:hive/hive.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/shared/utils/app_logger.dart';

class CacheManager {
  late final _CacheRepository _cacheRepository;

  Future<void> init() async {
    try {
      await initHive();
      _cacheRepository = _HiveCacheRepository();
      AppLogger().log(message: 'Using hive cache repository', logLevel: LogLevel.debug);
    } catch (e) {
      _cacheRepository = _MemoryCacheRepository();
      AppLogger().log(message: 'Using memory cache repository', logLevel: LogLevel.debug);
    }
  }

  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return _cacheRepository.get<T>(
      boxName: boxName,
      key: key,
      defaultValue: defaultValue,
    );
  }

  Map<String, T> getAll<T>({required String boxName}) {
    return _cacheRepository.getAll<T>(
      boxName: boxName,
    );
  }

  void add<T>({required String boxName, required String key, required T value}) {
    return _cacheRepository.add<T>(
      boxName: boxName,
      key: key,
      value: value,
    );
  }

  void delete<T>({required String boxName, required String key}) {
    return _cacheRepository.delete<T>(
      boxName: boxName,
      key: key,
    );
  }
}

class _HiveCacheRepository extends _CacheRepository {
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

class _MemoryCacheRepository extends _CacheRepository {
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

abstract class _CacheRepository {
  T get<T>({required String boxName, required String key, required T defaultValue});

  Map<String, T> getAll<T>({required String boxName});

  void add<T>({required String boxName, required String key, required T value});

  void delete<T>({required String boxName, required String key});
}
