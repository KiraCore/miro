import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/browser_url_controller.dart';
import 'package:miro/shared/utils/network_utils.dart';

class HttpClientManager {
  final AppConfig _appConfig = globalLocator<AppConfig>();

  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClientDio = _buildHttpClient(networkUri);
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClientDio = _buildHttpClient(networkUri);
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

  Dio _buildHttpClient(Uri uri) {
    String uriAsString = uri.toString();
    bool proxyActiveBool = NetworkUtils.shouldUseProxy(
      serverUri: uri,
      proxyServerUri: _appConfig.proxyServerUri,
      appUri: const BrowserUrlController().uri,
    );
    if (proxyActiveBool) {
      uriAsString = '${_appConfig.proxyServerUri}/${uri.toString()}';
      return DioForBrowser(
        BaseOptions(
          baseUrl: uriAsString,
          headers: <String, dynamic>{'Origin': uri.host},
        ),
      );
    } else {
      return DioForBrowser(BaseOptions(baseUrl: uriAsString));
    }
  }

  Map<String, dynamic>? _removeEmptyQueryParameters(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) {
      return null;
    }
    queryParameters.removeWhere((String key, dynamic value) => value == null);
    return queryParameters;
  }
}
