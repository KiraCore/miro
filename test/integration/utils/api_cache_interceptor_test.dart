import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/api_cache/api_cache_config.dart';
import 'package:miro/infra/cache/api_cache/api_cache_service.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/shared/utils/api_cache_interceptor.dart';
import 'package:miro/shared/utils/api_manager.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/utils/api_cache_interceptor_test.dart --platform chrome
Future<void> main() async {
  await initHive();
  await initLocator();

  CacheManager cacheManager = globalLocator<CacheManager>();
  await cacheManager.init();

  ApiManager apiManager = ApiManager();
  ApiCacheService apiCacheService = ApiCacheService(apiCacheConfig: const ApiCacheConfig());

  // Actual values for tests
  final Uri uri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

  group('Tests of caching when endpoint called first time', () {
    test('Should return remote response and add it to cache after successful call', () async {
      Response<dynamic> remoteResponse = await apiManager.get<dynamic>(
        networkUri: uri,
        path: '/api/status',
        cacheConfig: const ApiCacheConfig(
          maxAge: Duration(seconds: 3),
        ),
      );

      CachedResponse? cachedResponse = await apiCacheService.pullFromCache(remoteResponse.requestOptions);
      expect(
        jsonDecode(cachedResponse?.content as String) as Map<String, dynamic>,
        remoteResponse.data,
      );

      testPrint('Should return null value from data_source header if response is from server');
      expect(
        remoteResponse.headers[kCacheHeaderKey],
        null,
      );
    });
  });

  group('Tests of caching when endpoint called second time', () {
    test('Should return cached response if validDuration not expired', () async {
      Response<dynamic> cacheResponse = await apiManager.get<dynamic>(
        networkUri: uri,
        path: '/api/status',
        cacheConfig: const ApiCacheConfig(
          maxAge: Duration(seconds: 3),
        ),
      );

      CachedResponse? cachedResponse = await apiCacheService.pullFromCache(cacheResponse.requestOptions);
      expect(
        jsonDecode(cachedResponse?.content as String) as Map<String, dynamic>,
        cacheResponse.data,
      );

      testPrint('Should return cache value from data_source header if response is from cache');
      expect(
        cacheResponse.headers[kCacheHeaderKey],
        <String>[kCacheHeaderValue],
      );
    });
  });

  group('Tests of caching when endpoint called after valid time expired', () {
    test('Should return remote response and update cache if validDuration expired', () async {
      await Future<void>.delayed(const Duration(seconds: 4));
      Response<dynamic> responseAfterTime = await apiManager.get<dynamic>(
        networkUri: uri,
        path: '/api/status',
        cacheConfig: const ApiCacheConfig(
          maxAge: Duration(seconds: 3),
        ),
      );

      CachedResponse? cachedResponse = await apiCacheService.pullFromCache(responseAfterTime.requestOptions);
      expect(
        jsonDecode(cachedResponse?.content as String) as Map<String, dynamic>,
        responseAfterTime.data,
      );

      testPrint('Should return null value from data_source header if response is from server');
      expect(
        responseAfterTime.headers[kCacheHeaderKey],
        null,
      );
    });
  });
}
