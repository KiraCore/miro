import 'package:dio/dio.dart';

class DioConnectException implements Exception {
  final DioException dioException;

  DioConnectException({required this.dioException});
}
