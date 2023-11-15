import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/entity/cache/api_cache_response_entity.dart';
import 'package:miro/infra/models/api_cache_config_model.dart';
import 'package:miro/infra/models/api_cache_response_model.dart';
import 'package:miro/infra/repositories/cache/api_cache_repository.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';

class ApiCacheManager {
  final ApiCacheRepository _apiCacheRepository;

  ApiCacheManager({ApiCacheRepository? apiCacheRepository}) : _apiCacheRepository = apiCacheRepository ?? globalLocator<ApiCacheRepository>();

  Future<ApiCacheResponseModel> saveResponse(Response<dynamic> response, ApiCacheConfigModel apiCacheConfigModel) async {
    RequestOptions options = response.requestOptions;
    DateTime cacheStartTime = apiCacheConfigModel.cacheStartTime ?? DateTime.now();
    DateTime cacheExpirationDateTime = cacheStartTime.add(apiCacheConfigModel.apiCacheMaxAge);

    String requestId = _buildRequestId(options);

    ApiCacheResponseEntity apiCacheResponseEntity = ApiCacheResponseEntity(
      requestId: requestId,
      responseBody: response.data,
      cacheExpirationDateTime: cacheExpirationDateTime,
      statusCode: response.statusCode,
      headers: response.headers.map,
    );

    await _apiCacheRepository.saveResponse(apiCacheResponseEntity);
    return ApiCacheResponseModel.fromEntity(apiCacheResponseEntity);
  }

  Future<ApiCacheResponseModel?> readResponse(RequestOptions requestOptions) async {
    String requestId = _buildRequestId(requestOptions);
    ApiCacheResponseEntity? apiCacheResponseEntity = await _apiCacheRepository.readResponseByRequestId(requestId);

    if (apiCacheResponseEntity == null) {
      return null;
    } else {
      ApiCacheResponseModel apiCacheResponseModel = ApiCacheResponseModel.fromEntity(apiCacheResponseEntity);
      apiCacheResponseModel.headers
        ..set(InterxHeaders.dataSourceHeaderKey, InterxHeaders.dataSourceCacheHeaderValue)
        ..set(InterxHeaders.cacheExpirationTimeHeaderKey, apiCacheResponseModel.cacheExpirationDateTime.toString());
      return apiCacheResponseModel;
    }
  }

  Future<void> deleteResponse(RequestOptions requestOptions) async {
    String requestId = _buildRequestId(requestOptions);
    await _apiCacheRepository.deleteResponseByRequestId(requestId);
  }

  String _buildRequestId(RequestOptions requestOptions) {
    String urlString = requestOptions.uri.toString();
    String requestMethod = requestOptions.method;
    if (requestMethod == 'POST') {
      String dataHash = Sha256.encrypt(jsonEncode(requestOptions.data)).toString();
      return '$requestMethod|$urlString|$dataHash';
    } else {
      return '$requestMethod|$urlString';
    }
  }
}
