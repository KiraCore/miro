import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/infra_http_client_manager.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class IApiRepository {
  Future<Response<T>> fetchDashboard<T>(Uri networkUri);

  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri);

  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq);
}

class RemoteApiRepository implements IApiRepository {
  final InfraHttpClientManager _infraHttpClientManager = InfraHttpClientManager();

  @override
  Future<Response<T>> fetchDashboard<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _infraHttpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/dashboard',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiRepository: Cannot fetch fetchDashboard() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _infraHttpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/status',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiRepository: Cannot fetch fetchQueryInterxStatus() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq) async {
    try {
      final Response<T> response = await _infraHttpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/valopers',
        queryParameters: queryValidatorsReq.toJson(),
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiRepository: Cannot fetch fetchQueryValidators() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }
}
