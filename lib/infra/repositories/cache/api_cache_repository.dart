import 'dart:convert';

import 'package:miro/config/locator.dart';
import 'package:miro/infra/entity/cache/api_cache_response_entity.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';

class ApiCacheRepository {
  static const String boxName = 'api_cache';
  final ICacheManager _cacheManager;

  ApiCacheRepository({ICacheManager? cacheManager}) : _cacheManager = cacheManager ?? globalLocator<ICacheManager>();

  Future<void> saveResponse(ApiCacheResponseEntity apiCacheResponseEntity) async {
    String apiCacheResponseJsonText = jsonEncode(apiCacheResponseEntity.toJson());
    await _cacheManager.add<String>(boxName: boxName, key: apiCacheResponseEntity.requestId, value: apiCacheResponseJsonText);
  }

  Future<ApiCacheResponseEntity?> readResponseByRequestId(String requestId) async {
    String apiCacheResponseJsonText = _cacheManager.get<String>(boxName: boxName, key: requestId, defaultValue: '');
    if (apiCacheResponseJsonText.isEmpty) {
      return null;
    }
    Map<String, dynamic> apiCacheResponseJson = jsonDecode(apiCacheResponseJsonText) as Map<String, dynamic>;
    return ApiCacheResponseEntity.fromJson(apiCacheResponseJson);
  }

  Future<void> deleteResponseByRequestId(String requestId) async {
    await _cacheManager.delete<String>(boxName: boxName, key: requestId);
  }
}
