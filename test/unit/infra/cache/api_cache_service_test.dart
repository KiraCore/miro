import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/api_cache/api_cache_config.dart';
import 'package:miro/infra/cache/api_cache/api_cache_service.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';
import 'package:miro/infra/cache/cache_manager.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/cache/api_cache_service_test.dart --platform chrome
Future<void> main() async {
  const String cacheKey = 'request_cache';
  await initHive();
  await initLocator();

  CacheManager cacheManager = globalLocator<CacheManager>();
  await cacheManager.init();

  ApiCacheService longApiCacheService = ApiCacheService(
    apiCacheConfig: const ApiCacheConfig(
      maxAge: Duration(seconds: 4),
    ),
  );

  ApiCacheService shortApiCacheService = ApiCacheService(
    apiCacheConfig: const ApiCacheConfig(
      maxAge: Duration(seconds: 1),
    ),
  );

  // Actual values for tests
  Response<dynamic> actualResponse1 = Response<dynamic>(
    data: <String, dynamic>{
      'testKey1': 'testValue1',
    },
    headers: Headers.fromMap(<String, List<String>>{}),
    requestOptions: RequestOptions(
      method: 'GET',
      baseUrl: 'https://online.kira.network',
      path: '/test1',
    ),
    statusCode: 200,
  );

  Response<dynamic> actualResponse2 = Response<dynamic>(
    data: <String, dynamic>{
      'testKey2': 'testValue2',
    },
    headers: Headers.fromMap(<String, List<String>>{}),
    requestOptions: RequestOptions(
      method: 'GET',
      baseUrl: 'https://online.kira.network',
      path: '/test2',
    ),
    statusCode: 200,
  );

  Response<dynamic> actualResponse3 = Response<dynamic>(
    data: <String, dynamic>{
      'testKey3': 'testValue3',
    },
    headers: Headers.fromMap(<String, List<String>>{}),
    requestOptions: RequestOptions(
      method: 'GET',
      baseUrl: 'https://online.kira.network',
      path: '/test3',
    ),
    statusCode: 200,
  );

  Response<dynamic> actualResponse4 = Response<dynamic>(
    data: <String, dynamic>{
      'testKey4': 'testValue4',
    },
    headers: Headers.fromMap(<String, List<String>>{}),
    requestOptions: RequestOptions(
      method: 'GET',
      baseUrl: 'https://online.kira.network',
      path: '/test4',
    ),
    statusCode: 200,
  );

  // Expected values for tests
  CachedResponse expectedCachedResponse1 = CachedResponse.init(
    key: 'dbf8c9d0d39fe45fa5561630325f23c7',
    maxAge: const Duration(seconds: 4),
    content: '{"testKey1":"testValue1"}',
    statusCode: 200,
    headers: '{}',
  );

  CachedResponse expectedCachedResponse2 = CachedResponse.init(
    key: '6e109c94df709bdbe5815509536e8fda',
    maxAge: const Duration(seconds: 1),
    content: '{"testKey2":"testValue2"}',
    statusCode: 200,
    headers: '{}',
  );

  CachedResponse expectedCachedResponse3 = CachedResponse.init(
    key: 'fe1c264bd9269c63cd294913dc5cc99c',
    maxAge: const Duration(seconds: 4),
    content: '{"testKey3":"testValue3"}',
    statusCode: 200,
    headers: '{}',
  );

  CachedResponse expectedCachedResponse4 = CachedResponse.init(
    key: 'efe6c60fc3fa1baa2300af4c78b0f1c7',
    maxAge: const Duration(seconds: 1),
    content: '{"testKey4":"testValue4"}',
    statusCode: 200,
    headers: '{}',
  );

  group('Tests of pushToCache() method', () {
    test('Should return expectedCachedResponse1 after add actualResponse1 to cache', () async {
      await longApiCacheService.pushToCache(actualResponse1);
      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
        ],
      );
    });

    test('Should return expectedCachedResponse2 after add actualResponse2 to cache', () async {
      await shortApiCacheService.pushToCache(actualResponse2);

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
          expectedCachedResponse2.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
          expectedCachedResponse2,
        ],
      );
    });

    test('Should return expectedCachedResponse3 after add actualResponse3 to cache', () async {
      await longApiCacheService.pushToCache(actualResponse3);

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
          expectedCachedResponse2.key,
          expectedCachedResponse3.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
          expectedCachedResponse2,
          expectedCachedResponse3,
        ],
      );
    });

    test('Should return expectedCachedResponse4 after add actualResponse4 to cache', () async {
      await shortApiCacheService.pushToCache(actualResponse4);

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
          expectedCachedResponse2.key,
          expectedCachedResponse3.key,
          expectedCachedResponse4.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
          expectedCachedResponse2,
          expectedCachedResponse3,
          expectedCachedResponse4,
        ],
      );
    });
  });

  group('Tests of auto removing CachedResponse after maxAge delayed', () {
    test('Should return correct CachedObject on request to alive cached endpoint', () async {
      expect(
        await longApiCacheService.pullFromCache(actualResponse1.requestOptions),
        expectedCachedResponse1,
      );
    });

    test('Should return null on request to outdated cached endpoint', () async {
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        await longApiCacheService.pullFromCache(actualResponse2.requestOptions),
        null,
      );
    });

    test('Should return all expired cached requests', () async {
      await Future<void>.delayed(const Duration(seconds: 1));
      await longApiCacheService.clearExpired();

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
          expectedCachedResponse3.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
          expectedCachedResponse3,
        ],
      );
    });
  });

  group('Tests of delete() method', () {
    test('Should remove from cache specified element', () async {
      // Tests before delete
      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse1.key,
          expectedCachedResponse3.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse1,
          expectedCachedResponse3,
        ],
      );

      await longApiCacheService.delete(actualResponse1.requestOptions);
      // Tests after delete
      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[
          expectedCachedResponse3.key,
        ],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[
          expectedCachedResponse3,
        ],
      );
    });
  });

  group('Tests of clearAll() method', () {
    test('Should remove all elements from cache', () async {
      await longApiCacheService.clearAll();
      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).keys.toList(),
        <String>[],
      );

      expect(
        cacheManager.getAll<CachedResponse>(boxName: cacheKey).values.toList(),
        <CachedResponse>[],
      );
    });
  });
}
