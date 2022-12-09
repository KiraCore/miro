import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/browser_url_controller.dart';

class ApiManager {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final BrowserUrlController _browserUrlController = const BrowserUrlController();

  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClient = _buildHttpClient(networkUri);
      return await httpClient.get<T>(
        path,
        queryParameters: _removeEmptyQueryParameters(queryParameters),
        options: options,
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
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Dio httpClient = _buildHttpClient(networkUri);
      return await httpClient.post<T>(
        path,
        data: body,
        queryParameters: _removeEmptyQueryParameters(queryParameters),
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError {
      rethrow;
    }
  }

  Dio _buildHttpClient(Uri uri) {
    String uriAsString = uri.toString();
    bool useProxy = _shouldUseProxy(uri);
    if (useProxy) {
      uriAsString = '${_appConfig.proxyServerUri}/${uri.host}:${uri.port}';
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

  bool _shouldUseProxy(Uri serverUri) {
    Uri appUri = _browserUrlController.uri;
    bool hasRequiredScheme = appUri.isScheme('https') && serverUri.isScheme('http');
    return hasRequiredScheme && _appConfig.proxyServerUri != null;
  }

  Map<String, dynamic>? _removeEmptyQueryParameters(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) {
      return null;
    }
    queryParameters.removeWhere((String key, dynamic value) => value == null);
    return queryParameters;
  }
}
