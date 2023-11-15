import 'package:equatable/equatable.dart';

class ApiCacheResponseEntity extends Equatable {
  final String requestId;
  final DateTime cacheExpirationDateTime;
  final int? statusCode;
  final dynamic responseBody;
  final Map<String, List<String>> headers;

  const ApiCacheResponseEntity({
    required this.requestId,
    required this.cacheExpirationDateTime,
    this.statusCode,
    this.responseBody,
    this.headers = const <String, List<String>>{}
  });

  factory ApiCacheResponseEntity.fromJson(Map<String, dynamic> json) {
    return ApiCacheResponseEntity(
      requestId: json['request_id'] as String,
      cacheExpirationDateTime: DateTime.parse(json['cache_expiration_time'] as String),
      statusCode: json['status_code'] as int?,
      responseBody: json['response_body'],
      headers: (json['headers'] as Map<String, dynamic>).map((String key, dynamic value) {
        return MapEntry<String, List<String>>(key, List<String>.from(value as List<dynamic>));
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'request_id': requestId,
      'cache_expiration_time': cacheExpirationDateTime.toString(),
      'status_code': statusCode,
      'response_body': responseBody,
      'headers': headers,
    };
  }

  @override
  List<Object?> get props => <Object?>[requestId, cacheExpirationDateTime, statusCode, responseBody, headers];
}
