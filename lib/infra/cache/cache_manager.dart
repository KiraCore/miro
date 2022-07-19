import 'package:miro/config/hive.dart';
import 'package:miro/infra/cache/cache_repository/hive_cache_repository.dart';
import 'package:miro/infra/cache/cache_repository/i_cache_repository.dart';
import 'package:miro/infra/cache/cache_repository/memory_cache_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

class CacheManager {
  late final ICacheRepository _cacheRepository;

  Future<void> init() async {
    try {
      await initHive();
      _cacheRepository = HiveCacheRepository();
      AppLogger().log(message: 'Using hive cache repository', logLevel: LogLevel.debug);
    } catch (e) {
      _cacheRepository = MemoryCacheRepository();
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
