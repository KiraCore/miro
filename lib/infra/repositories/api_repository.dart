import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiRepository {
  /// throws [DioError]
  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri);

  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq);

  Future<Response<T>> fetchDashboard<T>(Uri networkUri);
}

class RemoteApiRepository implements ApiRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/status',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/valopers',
        queryParameters: queryValidatorsReq.toJson(),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchDashboard<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/dashboard',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
