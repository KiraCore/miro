import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/managers/api/http_client_manager.dart';
import 'package:miro/infra/models/api_cache_config_model.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class IApiRepository {
  Future<Response<T>> fetchDashboard<T>(ApiRequestModel<void> apiRequestModel);

  Future<Response<T>> fetchQueryInterxStatus<T>(ApiRequestModel<void> apiRequestModel);

  Future<Response<T>> fetchQueryTransactions<T>(ApiRequestModel<QueryTransactionsReq> apiRequestModel);

  Future<Response<T>> fetchQueryValidators<T>(ApiRequestModel<QueryValidatorsReq> apiRequestModel);

  Future<Response<T>> fetchQueryP2P<T>(ApiRequestModel<QueryP2PReq> apiRequestModel);
}

class RemoteApiRepository implements IApiRepository {
  final HttpClientManager _httpClientManager = HttpClientManager();

  @override
  Future<Response<T>> fetchDashboard<T>(ApiRequestModel<void> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/dashboard',
        apiCacheConfigModel: ApiCacheConfigModel(forceRequestBool: apiRequestModel.forceRequestBool),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchDashboard() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryInterxStatus<T>(ApiRequestModel<void> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/status',
        apiCacheConfigModel: ApiCacheConfigModel(forceRequestBool: apiRequestModel.forceRequestBool),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryInterxStatus() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryTransactions<T>(ApiRequestModel<QueryTransactionsReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/transactions',
        queryParameters: apiRequestModel.requestData.toJson(),
        apiCacheConfigModel: ApiCacheConfigModel(forceRequestBool: apiRequestModel.forceRequestBool),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryTransactions() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryValidators<T>(ApiRequestModel<QueryValidatorsReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/valopers',
        queryParameters: apiRequestModel.requestData.toJson(),
        apiCacheConfigModel: ApiCacheConfigModel(forceRequestBool: apiRequestModel.forceRequestBool),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryValidators() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryP2P<T>(ApiRequestModel<QueryP2PReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/pub_p2p_list',
        queryParameters: apiRequestModel.requestData.toJson(),
        apiCacheConfigModel: ApiCacheConfigModel(forceRequestBool: apiRequestModel.forceRequestBool),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiRepository: Cannot fetch fetchQueryP2P() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }
}
