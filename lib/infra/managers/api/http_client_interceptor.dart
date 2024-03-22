import 'package:dio/dio.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/managers/cache/api_cache_manager.dart';
import 'package:miro/infra/models/api_cache_config_model.dart';
import 'package:miro/infra/models/api_cache_response_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class HttpClientInterceptor extends Interceptor {
  final ApiCacheManager apiCacheManager = ApiCacheManager();
  final ApiCacheConfigModel apiCacheConfigModel;

  HttpClientInterceptor({
    required this.apiCacheConfigModel,
  });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AppLogger().logApiRequest(options);
    DateTime currentTime = apiCacheConfigModel.cacheStartTime ?? DateTime.now();

    if (apiCacheConfigModel.cacheEnabledBool == false) {
      AppLogger().logApiInterceptor(options, 'SERVER | Cache disabled. Fetch from server.');

      // Fetch [Response] from server and call [onResponse] if server responds with a (2XX) status code or [onError] if not
      return handler.next(options);
    }

    if (apiCacheConfigModel.forceRequestBool) {
      AppLogger().logApiInterceptor(options, 'SERVER | Forced request. Fetch from server.');

      // Fetch [Response] from server and call [onResponse] if server responds with a (2XX) status code or [onError] if not
      return handler.next(options);
    }

    ApiCacheResponseModel? apiCacheResponseModel = await apiCacheManager.readResponse(options);

    // Fetch from server when cached response not exists
    if (apiCacheResponseModel == null) {
      AppLogger().logApiInterceptor(options, 'SERVER | Cached response not exists. Fetch from server.');

      // Fetch [Response] from server and call [onResponse] if server responds with a (2XX) status code or [onError] if not
      return handler.next(options);
    }

    int secondsToExpiry = apiCacheResponseModel.getTimeToExpiry(currentTime).inSeconds.abs();

    // Fetch from server when cached response exists but is expired
    if (apiCacheResponseModel.isExpired(currentTime)) {
      AppLogger().logApiInterceptor(options, 'SERVER | Cached response exists, but expired $secondsToExpiry seconds ago. Fetch from server.');
      await apiCacheManager.deleteResponse(options);

      // Fetch [Response] from server and call [onResponse] if server responds with a (2XX) status code or [onError] if not
      return handler.next(options);
    }

    Response<dynamic> response = apiCacheResponseModel.buildDioResponse(options);
    AppLogger().logApiInterceptor(options, 'CACHE | Fetch response from cache. $secondsToExpiry seconds left.');

    // Return cached [Response] directly - without calling [onResponse] or [onError] method
    return handler.resolve(response);
  }

  @override
  Future<void> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (apiCacheConfigModel.cacheEnabledBool) {
      ApiCacheResponseModel apiCacheResponseModel = await apiCacheManager.saveResponse(response, apiCacheConfigModel);
      response.headers.set(InterxHeaders.cacheExpirationTimeHeaderKey, apiCacheResponseModel.cacheExpirationDateTime.toString());
    }
    response.headers.set(InterxHeaders.dataSourceHeaderKey, InterxHeaders.dataSourceApiHeaderValue);

    return handler.next(response);
  }

  /// This method is called when server responds with one of the following status codes (1XX), (3XX), (4XX) or (5XX)
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (apiCacheConfigModel.forceRequestBool) {
      // Redirect [DioException] to the [HttpClientManager]
      return handler.next(err);
    }
    ApiCacheResponseModel? apiCacheResponseModel = await apiCacheManager.readResponse(err.requestOptions);

    bool cachedResponseExistsBool = apiCacheResponseModel != null;
    if (cachedResponseExistsBool) {
      Response<dynamic> response = apiCacheResponseModel.buildDioResponse(err.requestOptions);
      // Return cached [Response] directly - without calling [onResponse] method
      return handler.resolve(response);
    } else {
      // Redirect [DioException] to the [HttpClientManager]
      return handler.next(err);
    }
  }
}
