import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:miro/infra/cache/api_cache/api_cache_config.dart';
import 'package:miro/infra/cache/api_cache/api_cache_service.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';

const String kCacheHeaderKey = 'data_source';
const String kCacheHeaderValue = 'cache';

class ApiCacheManager {
  InterceptorsWrapper? _interceptor;

  final ApiCacheConfig apiCacheConfig;
  final ApiCacheService apiCacheService;

  ApiCacheManager({
    required this.apiCacheConfig,
  }) : apiCacheService = ApiCacheService(apiCacheConfig: apiCacheConfig);

  /// Interceptor for dio cache.
  Interceptor? get interceptor {
    _interceptor ??= InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError,
    );
    return _interceptor;
  }

  Future<void> _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (apiCacheConfig.force) {
      return handler.next(options);
    }
    CachedResponse? cachedResponse = await apiCacheService.pullFromCache(options);
    if (cachedResponse != null) {
      Response<dynamic> response = _getDioResponse(
        cachedResponse,
        options,
      );
      // TODO(dominik): Debug print
      print(
        'CACHE | Get response from cache. ${Duration(milliseconds: cachedResponse.maxAgeMilliseconds - DateTime.now().millisecondsSinceEpoch).inSeconds} seconds left',
      );
      return handler.resolve(response, true);
    }
    // TODO(dominik): Debug print
    print('SERVER | Cached response not exists. Fetch from server');
    return handler.next(options);
  }

  Future<void> _onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    if (_wantsCacheResponse(response)) {
      await apiCacheService.pushToCache(response);
    }
    return handler.next(response);
  }

  Future<void> _onError(DioError e, ErrorInterceptorHandler handler) async {
    CachedResponse? cachedResponse = await apiCacheService.pullFromCache(e.requestOptions);
    if (cachedResponse != null) {
      Response<dynamic> response = _getDioResponse(
        cachedResponse,
        e.requestOptions,
      );
      return handler.resolve(response);
    }
    return handler.next(e);
  }

  bool _wantsCacheResponse(Response<dynamic> response) {
    List<String> cacheHeaders = response.headers[kCacheHeaderKey] ?? List<String>.empty();
    if (cacheHeaders.isNotEmpty && cacheHeaders.contains(kCacheHeaderValue)) {
      return false;
    }

    return response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300;
  }

  Response<dynamic> _getDioResponse(CachedResponse cachedResponse, RequestOptions options) {
    Headers? headers = _buildCachedResponseHeaders(cachedResponse, options);
    String? encodedResponseData = cachedResponse.content;
    dynamic parsedResponse = jsonDecode(encodedResponseData!);
    return Response<dynamic>(
      data: parsedResponse,
      headers: headers,
      requestOptions: options,
      statusCode: cachedResponse.statusCode ?? 200,
    );
  }

  Headers _buildCachedResponseHeaders(CachedResponse cachedResponse, RequestOptions options) {
    Headers? headers;
    if (cachedResponse.headers != null) {
      headers = Headers.fromMap(_decodeHeaders(cachedResponse.headers!));
    } else {
      headers = Headers();
      options.headers.forEach((String key, dynamic value) => headers!.add(key, value as String? ?? ''));
    }
    // Add info to headers about response source
    headers.add(kCacheHeaderKey, kCacheHeaderValue);
    return headers;
  }

  Map<String, List<String>> _decodeHeaders(String encodedHeaders) {
    Map<String, List<String>> headers = (jsonDecode(encodedHeaders) as Map<String, dynamic>).map(
      (String key, dynamic value) => MapEntry<String, List<String>>(key, List<String>.from(value as List<dynamic>)),
    );
    return headers;
  }
}
