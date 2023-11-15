import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/entity/cache/api_cache_response_entity.dart';

class ApiCacheResponseModel extends Equatable {
  final String requestId;
  final DateTime cacheExpirationDateTime;
  final Headers headers;
  final int? statusCode;
  final dynamic responseBody;

  const ApiCacheResponseModel({
    required this.requestId,
    required this.cacheExpirationDateTime,
    required this.headers,
    this.statusCode,
    this.responseBody,
  });

  factory ApiCacheResponseModel.fromEntity(ApiCacheResponseEntity apiCacheResponseEntity) {
    return ApiCacheResponseModel(
      requestId: apiCacheResponseEntity.requestId,
      cacheExpirationDateTime: apiCacheResponseEntity.cacheExpirationDateTime,
      statusCode: apiCacheResponseEntity.statusCode,
      responseBody: apiCacheResponseEntity.responseBody,
      headers: Headers.fromMap(apiCacheResponseEntity.headers),
    );
  }

  bool isExpired(DateTime currentDateTime) {
    return cacheExpirationDateTime.isBefore(currentDateTime);
  }

  Duration getTimeToExpiry(DateTime currentDateTime) {
    return cacheExpirationDateTime.difference(currentDateTime);
  }

  Response<dynamic> buildDioResponse(RequestOptions requestOptions) {
    return Response<dynamic>(
      data: responseBody,
      headers: headers,
      requestOptions: requestOptions,
      statusCode: statusCode ?? 200,
    );
  }

  @override
  List<Object?> get props => <Object?>[requestId, cacheExpirationDateTime, statusCode, responseBody, headers.toString()];
}
