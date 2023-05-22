import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/browser_url_controller.dart';
import 'package:miro/shared/utils/network_utils.dart';

class HttpClientManager {
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
      Dio httpClientDio = _buildHttpClient(networkUri);
      return await httpClientDio.get<T>(
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
      Dio httpClientDio = _buildHttpClient(networkUri);
      return await httpClientDio.post<T>(
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
    bool proxyActiveBool = _shouldUseProxy(uri);
    if (proxyActiveBool) {
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
    
    bool requiredSchemeExistsBool = appUri.isScheme('https') && serverUri.isScheme('http');
    bool proxyUrlExistsBool = _appConfig.proxyServerUri != null;
    bool localhostServerBool = NetworkUtils.isLocalhost(serverUri);
    
    bool useProxyBool = requiredSchemeExistsBool && proxyUrlExistsBool && localhostServerBool == false;
    return useProxyBool;
  }

  Map<String, dynamic>? _removeEmptyQueryParameters(Map<String, dynamic>? queryParameters) {
    if (queryParameters == null) {
      return null;
    }
    queryParameters.removeWhere((String key, dynamic value) => value == null);
    return queryParameters;
  }
}
