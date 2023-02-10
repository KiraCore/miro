import 'package:dio/dio.dart';

class DioConnectException implements Exception {
  final DioError dioError;

  DioConnectException({required this.dioError});
}
