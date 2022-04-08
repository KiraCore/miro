import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:hex/hex.dart';
import 'package:miro/infra/cache/api_cache/api_cache_config.dart';
import 'package:miro/infra/cache/api_cache/api_cache_store.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';
import 'package:miro/shared/utils/app_logger.dart';

class ApiCacheService {
  final ApiCacheStore _apiCacheStore = ApiCacheStore();
  final ApiCacheConfig apiCacheConfig;

  ApiCacheService({
    required this.apiCacheConfig,
  });

  Future<CachedResponse?> pullFromCache(RequestOptions requestOptions) async {
    String cacheKey = _generateKey(requestOptions);
    CachedResponse? cachedResponse = await _apiCacheStore.getCachedResponse(cacheKey);
    if (cachedResponse != null) {
      int now = DateTime.now().millisecondsSinceEpoch;
      // Remove it if maxAgeDate expired.
      if (cachedResponse.maxAgeMilliseconds < now) {
        print(
          'Cache expired ${Duration(milliseconds: now - cachedResponse.maxAgeMilliseconds).inSeconds} seconds ago. Removing from cache.',
        );
        await delete(requestOptions);
        return null;
      }
    }
    return cachedResponse;
  }

  Future<bool> pushToCache(Response<dynamic> response) async {
    RequestOptions options = response.requestOptions;
    Duration? maxAge = apiCacheConfig.maxAge;

    String? data = jsonEncode(response.data);
    CachedResponse cachedResponse = CachedResponse.init(
      key: _generateKey(options),
      content: data,
      maxAge: maxAge,
      statusCode: response.statusCode,
      headers: jsonEncode(response.headers.map),
    );
    return _apiCacheStore.setCachedResponse(cachedResponse);
  }

  Future<bool> delete(RequestOptions requestOptions) async {
    String cacheKey = _generateKey(requestOptions);
    return _apiCacheStore.delete(cacheKey);
  }

  Future<bool> clearExpired() async {
    return _apiCacheStore.clearExpired();
  }

  Future<bool> clearAll() async {
    return _apiCacheStore.clearAll();
  }

  String _generateKey(RequestOptions requestOptions) {
    String urlString = requestOptions.uri.toString();
    String requestMethod = _getRequestMethod(requestOptions.method);
    String key = '$requestMethod|$urlString';
    String encodedKey = _encodeMd5(key);
    return encodedKey;
  }

  String _getRequestMethod(String? requestMethod) {
    if (requestMethod != null && requestMethod.isNotEmpty) {
      return requestMethod.toUpperCase();
    }
    AppLogger().log(message: 'Cache: Request method for request is undefined', logLevel: LogLevel.warning);
    return 'UNDEFINED';
  }

  String _encodeMd5(String value) {
    Utf8Encoder _utf8encoder = const Utf8Encoder();
    List<int> hashBytes = md5.convert(_utf8encoder.convert(value)).bytes;
    return HEX.encode(hashBytes);
  }
}
