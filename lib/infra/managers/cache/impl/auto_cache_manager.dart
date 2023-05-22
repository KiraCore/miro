import 'package:flutter/material.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/hive_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

class AutoCacheManager implements ICacheManager {
  @visibleForTesting
  late final ICacheManager cacheManager;

  @override
  Future<void> init({HiveCacheManager? customHiveCacheManager, MemoryCacheManager? customMemoryCacheManager}) async {
    try {
      HiveCacheManager hiveCacheManager = customHiveCacheManager ?? HiveCacheManager();
      await hiveCacheManager.init();
      cacheManager = hiveCacheManager;
      AppLogger().log(message: 'Using hive cache repository', logLevel: LogLevel.debug);
    } catch (e) {
      cacheManager = customMemoryCacheManager ?? MemoryCacheManager();
      AppLogger().log(message: 'Using memory cache repository', logLevel: LogLevel.debug);
    }
  }

  @override
  Future<void> add<T>({required String boxName, required String key, required T value}) async {
    return cacheManager.add<T>(
      boxName: boxName,
      key: key,
      value: value,
    );
  }

  @override
  Future<void> delete<T>({required String boxName, required String key}) async {
    return cacheManager.delete<T>(
      boxName: boxName,
      key: key,
    );
  }

  @override
  Future<void> deleteAll<T>({required String boxName}) async {
    return cacheManager.deleteAll<T>(
      boxName: boxName,
    );
  }

  @override
  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return cacheManager.get<T>(
      boxName: boxName,
      key: key,
      defaultValue: defaultValue,
    );
  }

  @override
  Map<String, T> getAll<T>({required String boxName}) {
    return cacheManager.getAll<T>(
      boxName: boxName,
    );
  }
}
