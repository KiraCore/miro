import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';
import 'package:miro/infra/cache/cache_manager.dart';

abstract class _ApiCacheStore {
  Future<CachedResponse?> getCachedResponse(String key);

  Future<bool> setCachedResponse(CachedResponse cachedResponse);

  Future<bool> delete(String key);

  Future<bool> clearExpired();

  Future<bool> clearAll();
}

class ApiCacheStore extends _ApiCacheStore {
  final String boxName = 'request_cache';
  final CacheManager _cacheManager = globalLocator<CacheManager>();

  @override
  Future<bool> clearAll() {
    _cacheManager.deleteAll<CachedResponse>(boxName: boxName);
    return Future<bool>.value(true);
  }

  @override
  Future<bool> clearExpired() {
    Iterable<CachedResponse> cachedResponses = _cacheManager.getAll<CachedResponse>(boxName: boxName).values;
    for (CachedResponse cacheResponse in cachedResponses) {
      if (cacheResponse.expired) {
        delete(cacheResponse.key);
      }
    }
    return Future<bool>.value(true);
  }

  @override
  Future<bool> delete(String key) {
    _cacheManager.delete<CachedResponse>(boxName: boxName, key: key);
    return Future<bool>.value(true);
  }

  @override
  Future<CachedResponse?> getCachedResponse(String key) {
    CachedResponse cachedResponse = _cacheManager.get<CachedResponse>(
      boxName: boxName,
      key: key,
      defaultValue: CachedResponse(key: key, maxAgeMilliseconds: 0, statusCode: 0),
    );
    if (cachedResponse.content == null) {
      return Future<CachedResponse?>.value(null);
    }
    return Future<CachedResponse?>.value(cachedResponse);
  }

  @override
  Future<bool> setCachedResponse(CachedResponse cachedResponse) {
    _cacheManager.add<CachedResponse>(boxName: boxName, key: cachedResponse.key, value: cachedResponse);
    return Future<bool>.value(true);
  }
}
