import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'package:miro/infra/cache/api_cache/api_cache_config.dart';
import 'package:miro/shared/utils/api_cache_interceptor.dart';

class ApiManager {
  Dio _getDio({required Uri networkUri, required ApiCacheConfig apiCacheConfig, required String method}) {
    Dio dio = DioForBrowser(
      BaseOptions(baseUrl: networkUri.toString()),
    )..interceptors.add(
        ApiCacheManager(
          apiCacheConfig: apiCacheConfig,
        ).interceptor!,
      );

    return dio;
  }

  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    ApiCacheConfig cacheConfig = const ApiCacheConfig(),
    bool wantsClearQueryParameters = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    _printUrl(method: 'GET', networkUri: networkUri.toString(), path: path, queryParameters: queryParameters);
    try {
      final Dio server = _getDio(
        networkUri: networkUri,
        apiCacheConfig: cacheConfig,
        method: 'GET',
      );

      return await server.get<T>(
        path,
        queryParameters: wantsClearQueryParameters ? _prepareQueryParameters(queryParameters) : queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError {
      rethrow;
    }
  }

  Future<Response<T>> post<T>({
    required Uri networkUri,
    required String path,
    required Map<String, dynamic> body,
    bool wantsClearQueryParameters = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio server = DioForBrowser(BaseOptions(baseUrl: networkUri.toString()));
      return await server.post<T>(
        path,
        data: body,
        queryParameters: wantsClearQueryParameters ? _prepareQueryParameters(queryParameters) : queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError {
      rethrow;
    }
  }

  Map<String, dynamic>? _prepareQueryParameters(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) {
      return null;
    }
    queryParameters.removeWhere((String key, dynamic value) => value == null);
    return queryParameters;
  }

  // TODO(dominik): Debug method
  void _printUrl(
      {required String method,
      required String networkUri,
      String? path,
      Map<String, dynamic>? queryParameters,
      dynamic body}) {
    String printValue = '$method | $networkUri';
    if (path != null) {
      printValue += path;
    }
    if (queryParameters != null) {
      printValue +=
          '?${queryParameters.keys.map((String key) => queryParameters[key] != null ? '$key=${queryParameters[key]}' : '').toList().where((String e) => e != '').join('&')}';
    }
    print(printValue);
    if (body != null) {
      print('Body: $body');
    }
  }
}
