import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/api/http_client_interceptor.dart';
import 'package:miro/infra/models/api_cache_config_model.dart';
import 'package:miro/shared/controllers/browser/browser_url_controller.dart';
import 'package:miro/shared/utils/network_utils.dart';

class HttpClientManager {
  final AppConfig _appConfig = globalLocator<AppConfig>();

  final Dio? customDio;

  HttpClientManager({this.customDio});

  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    required ApiCacheConfigModel apiCacheConfigModel,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClientDio = _buildHttpClient(networkUri, apiCacheConfigModel);
      return await httpClientDio.get<T>(
        path,
        queryParameters: _removeEmptyQueryParameters(queryParameters),
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response<T>> post<T>({
    required Uri networkUri,
    required String path,
    required Map<String, dynamic> body,
    required ApiCacheConfigModel apiCacheConfigModel,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClientDio = _buildHttpClient(networkUri, apiCacheConfigModel);
      return await httpClientDio.post<T>(
        path,
        data: body,
        queryParameters: _removeEmptyQueryParameters(queryParameters),
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException {
      rethrow;
    }
  }

  Dio _buildHttpClient(Uri uri, ApiCacheConfigModel apiCacheConfigModel) {
    String uriAsString = uri.toString();
    bool proxyActiveBool = NetworkUtils.shouldUseProxy(
      serverUri: uri,
      proxyServerUri: _appConfig.proxyServerUri,
      appUri: const BrowserUrlController().uri,
    );
    Dio httpClientDio;
    if (customDio != null) {
      httpClientDio = customDio!;
    } else if (proxyActiveBool) {
      uriAsString = '${_appConfig.proxyServerUri}/${uri.toString()}';
      httpClientDio = DioForBrowser(
        BaseOptions(
          baseUrl: uriAsString,
          headers: <String, dynamic>{'Origin': uri.host},
        ),
      );
    } else {
      httpClientDio = DioForBrowser(BaseOptions(baseUrl: uriAsString));
    }
    httpClientDio.interceptors.add(HttpClientInterceptor(apiCacheConfigModel: apiCacheConfigModel));
    return httpClientDio;
  }

  Map<String, dynamic>? _removeEmptyQueryParameters(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) {
      return null;
    }
    queryParameters.removeWhere((String key, dynamic value) => value == null);
    return queryParameters;
  }
}
