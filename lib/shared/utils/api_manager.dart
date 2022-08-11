import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

class ApiManager {
  Future<Response<T>> get<T>({
    required Uri networkUri,
    required String path,
    bool wantsClearQueryParameters = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio server = DioForBrowser(BaseOptions(baseUrl: networkUri.toString()));
      return await server.get<T>(
        path,
        queryParameters: wantsClearQueryParameters ? _prepareQueryParameters(queryParameters) : queryParameters,
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
}
