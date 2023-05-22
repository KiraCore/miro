import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/managers/cache/impl/auto_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/hive_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/managers/cache/auto_cache_manager_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
void main() {
  group('Tests of AutoCacheManager.init()', (){
    test('Should initialize [HiveCacheManager] if [Hive package supported]', () async {
      // Arrange
      AutoCacheManager actualAutoCacheManager = AutoCacheManager();

      // Act
      await actualAutoCacheManager.init();
      Type actualCacheManagerType = actualAutoCacheManager.cacheManager.runtimeType;

      // Assert
      Type expectedCacheManagerType = HiveCacheManager;

      expect(actualCacheManagerType, expectedCacheManagerType);
    });

    test('Should initialize [MemoryCacheManager] if [Hive package NOT supported]', () async {
      // Arrange
      AutoCacheManager actualAutoCacheManager = AutoCacheManager();

      // Act
      await actualAutoCacheManager.init(
        customHiveCacheManager: _MockHiveCacheManager(),
      );
      Type actualCacheManagerType = actualAutoCacheManager.cacheManager.runtimeType;

      // Assert
      Type expectedCacheManagerType = MemoryCacheManager;

      expect(actualCacheManagerType, expectedCacheManagerType);
    });
  });

  // Tests for specific method implementations are included in separate tests for each cache manager
  // - hive_cache_manager_test.dart
  // - memory_cache_manager_test.dart
}

class _MockHiveCacheManager extends HiveCacheManager {
  @override
  Future<void> init() async {
    throw Exception('Hive manager is not supported');
  }
}