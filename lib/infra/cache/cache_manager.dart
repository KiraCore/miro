import 'package:miro/config/hive.dart';
import 'package:miro/infra/cache/a_cache_repository.dart';
import 'package:miro/infra/cache/hive_cache_repository.dart';
import 'package:miro/infra/cache/memory_cache_repository.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

class CacheManager {
  late final ACacheRepository cacheRepository;

  Future<void> init() async {
    try {
      await initHive();
      cacheRepository = HiveCacheRepository();
      AppLogger().log(message: 'Using hive cache repository', logLevel: LogLevel.debug);
    } catch (e) {
      cacheRepository = MemoryCacheRepository();
      AppLogger().log(message: 'Using memory cache repository', logLevel: LogLevel.debug);
    }
  }

  T get<T>({required String boxName, required String key, required T defaultValue}) {
    return cacheRepository.get<T>(
      boxName: boxName,
      key: key,
      defaultValue: defaultValue,
    );
  }

  Map<String, T> getAll<T>({required String boxName}) {
    return cacheRepository.getAll<T>(
      boxName: boxName,
    );
  }

  void add<T>({required String boxName, required String key, required T value}) {
    return cacheRepository.add<T>(
      boxName: boxName,
      key: key,
      value: value,
    );
  }

  void delete<T>({required String boxName, required String key}) {
    return cacheRepository.delete<T>(
      boxName: boxName,
      key: key,
    );
  }
}
