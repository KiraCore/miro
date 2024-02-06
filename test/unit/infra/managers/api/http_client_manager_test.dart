import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_mock_adapter/src/handlers/request_handler.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/api/http_client_manager.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/models/api_cache_config_model.dart';
import 'package:miro/test/mock_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/managers/api/http_client_manager_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initMockLocator();

  Uri actualBaseUri = Uri.parse('https://test.server');

  Map<String, dynamic> expectedGETResponseData = <String, dynamic>{'message': 'success_get_response'};
  Map<String, dynamic> expectedPOSTResponseData = <String, dynamic>{'message': 'success_post_response'};

  late HttpClientManager httpClientManager;

  setUp(() async {
    Dio mockedDio = Dio(BaseOptions(baseUrl: actualBaseUri.toString()));

    DioAdapter dioAdapter = DioAdapter(dio: mockedDio);
    dioAdapter.onGet('/success', (MockServer server) {
      return server.reply(
        200,
        <String, dynamic>{'message': 'success_get_response'},
      );
    });

    dioAdapter.onGet('/error', (MockServer server) {
      return server.reply(
        500,
        <String, dynamic>{'message': 'error_get_response'},
      );
    });

    dioAdapter.onPost('/success', data: <String, dynamic>{}, (MockServer server) {
      return server.reply(
        200,
        <String, dynamic>{'message': 'success_post_response'},
      );
    });

    dioAdapter.onPost('/error', data: <String, dynamic>{}, (MockServer server) {
      return server.reply(
        500,
        <String, dynamic>{'message': 'error_get_response'},
      );
    });

    mockedDio.httpClientAdapter = dioAdapter;
    httpClientManager = HttpClientManager(customDio: mockedDio);
  });

  group('Tests of HttpClientManager.get()', () {
    group('Tests of HttpClientManager behaviour when [request FORCED]', () {
      test('Should [return SERVER response] if [query NOT EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      test('Should [return SERVER response] if [query EXISTS] in cache but [request FORCED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3), forceRequestBool: true),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [cache EXPIRED]', () {
      test('Should [return SERVER response] if [query NOT EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      test('Should [return SERVER response] if [query EXISTS] in cache but [cache EXPIRED]', () async {
        // Act
        await Future<void>.delayed(const Duration(seconds: 3));
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] after [expired cache REFRESH]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [ERROR exist]', () {
      test('Should [throw DioException] if [query NOT EXISTS] in cache and server returns error', () async {
        // Assert
        expect(
          () => httpClientManager.get<dynamic>(
            networkUri: actualBaseUri,
            path: '/error',
            apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('Should [request SERVER] if previous query failed and [throw DioException] if server still returns error', () async {
        // Assert
        expect(
          () => httpClientManager.get<dynamic>(
            networkUri: actualBaseUri,
            path: '/error',
            apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          ),
          throwsA(isA<DioException>()),
        );
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [cache DISABLED]', () {
      test('Should [return SERVER response] if [cache DISABLED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(
            apiCacheMaxAge: const Duration(seconds: 3),
            cacheEnabledBool: false,
          ),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return same SERVER response] again if [cache DISABLED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.get<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(
            apiCacheMaxAge: const Duration(seconds: 3),
            cacheEnabledBool: false,
          ),
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedGETResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });
  });

  group('Tests of HttpClientManager.post()', () {
    group('Tests of HttpClientManager behaviour when [request FORCED]', () {
      test('Should [return SERVER response] if [query NOT EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      test('Should [return SERVER response] if [query EXISTS] in cache but [request FORCED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3), forceRequestBool: true),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [cache EXPIRED]', () {
      test('Should [return SERVER response] if [query NOT EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<dynamic>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] if [query EXISTS] in cache', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      test('Should [return SERVER response] if [query EXISTS] in cache but [cache EXPIRED]', () async {
        // Act
        await Future<void>.delayed(const Duration(seconds: 3));

        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return CACHED response] after [expired cache REFRESH]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'cache');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [ERROR exist]', () {
      test('Should [throw DioException] if [query NOT EXISTS] in cache and server returns error', () async {
        // Assert
        expect(
          () => httpClientManager.post<dynamic>(
            networkUri: actualBaseUri,
            path: '/error',
            apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
            body: <String, dynamic>{},
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('Should [request SERVER] if previous query failed and [throw DioException] if server still returns error', () async {
        // Assert
        expect(
          () => httpClientManager.post<dynamic>(
            networkUri: actualBaseUri,
            path: '/error',
            apiCacheConfigModel: ApiCacheConfigModel(apiCacheMaxAge: const Duration(seconds: 3)),
            body: <String, dynamic>{},
          ),
          throwsA(isA<DioException>()),
        );
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });

    group('Tests of HttpClientManager behaviour when [cache DISABLED]', () {
      test('Should [return SERVER response] if [cache DISABLED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(
            apiCacheMaxAge: const Duration(seconds: 3),
            cacheEnabledBool: false,
          ),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      test('Should [return same SERVER response] again if [cache DISABLED]', () async {
        // Act
        Response<dynamic> actualResponse = await httpClientManager.post<Map<String, dynamic>>(
          networkUri: actualBaseUri,
          path: '/success',
          apiCacheConfigModel: ApiCacheConfigModel(
            apiCacheMaxAge: const Duration(seconds: 3),
            cacheEnabledBool: false,
          ),
          body: <String, dynamic>{},
        );
        String? actualDataSourceHeader = actualResponse.headers.value('data_source');

        // Assert
        expect(actualResponse.data, expectedPOSTResponseData);
        expect(actualDataSourceHeader, 'api');
      });

      tearDownAll(() {
        globalLocator<ICacheManager>().deleteAll(boxName: 'api_cache');
      });
    });
  });
}
