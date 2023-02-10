import 'package:dio/dio.dart';

class DioParseException implements Exception {
  final Response<dynamic> response;
  final Object error;

  DioParseException({
    required this.response,
    required this.error,
  });
}
