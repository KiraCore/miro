import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';

class ErrorExplorerModel extends Equatable {
  final Uri uri;
  final String method;
  final String code;
  final String? message;
  final dynamic request;
  final dynamic response;

  const ErrorExplorerModel({
    required this.uri,
    required this.method,
    required this.code,
    this.message,
    this.request,
    this.response,
  });

  factory ErrorExplorerModel.fromDioConnectException(DioConnectException dioConnectException) {
    DioException dioException = dioConnectException.dioException;
    RequestOptions requestOptions = dioException.requestOptions;

    return ErrorExplorerModel(
      code: 'NETWORK_ERROR',
      message: 'Cannot reach the server. Please check your internet connection.',
      uri: requestOptions.uri,
      method: requestOptions.method,
      request: requestOptions.data,
      response: dioException.response?.data ?? dioException.message,
    );
  }

  factory ErrorExplorerModel.fromDioParseException(DioParseException dioParseException) {
    RequestOptions requestOptions = dioParseException.response.requestOptions;

    return ErrorExplorerModel(
      code: 'PARSE_ERROR',
      message: dioParseException.error.toString(),
      uri: requestOptions.uri,
      method: requestOptions.method,
      request: requestOptions.data,
      response: dioParseException.response.data,
    );
  }

  @override
  List<Object?> get props => <Object?>[uri, method, code, message, request, response];
}
