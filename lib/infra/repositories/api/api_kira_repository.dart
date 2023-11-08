import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_requester_req.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/request/query_staking_pool_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/managers/api/http_client_manager.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class IApiKiraRepository {
  Future<Response<T>> broadcast<T>(ApiRequestModel<BroadcastReq> apiRequestModel);

  Future<Response<T>> fetchQueryAccount<T>(ApiRequestModel<QueryAccountReq> apiRequestModel);

  Future<Response<T>> fetchQueryBalance<T>(ApiRequestModel<QueryBalanceReq> apiRequestModel);

  Future<Response<T>> fetchQueryDelegations<T>(ApiRequestModel<QueryDelegationsReq> apiRequestModel);

  Future<Response<T>> fetchQueryExecutionFee<T>(ApiRequestModel<QueryExecutionFeeRequest> apiRequestModel);

  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(ApiRequestModel<String> apiRequestModel);

  Future<Response<T>> fetchQueryIdentityRecordById<T>(ApiRequestModel<String> apiRequestModel);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(ApiRequestModel<QueryIdentityRecordVerifyRequestsByApproverReq> apiRequestModel);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(ApiRequestModel<QueryIdentityRecordVerifyRequestsByRequesterReq> apiRequestModel);

  Future<Response<T>> fetchQueryKiraTokensAliases<T>(ApiRequestModel<void> apiRequestModel);

  Future<Response<T>> fetchQueryKiraTokensRates<T>(ApiRequestModel<void> apiRequestModel);

  Future<Response<T>> fetchQueryNetworkProperties<T>(ApiRequestModel<void> apiRequestModel);

  Future<Response<T>> fetchQueryStakingPool<T>(ApiRequestModel<QueryStakingPoolReq> apiRequestModel);
}

class RemoteApiKiraRepository implements IApiKiraRepository {
  final HttpClientManager _httpClientManager = HttpClientManager();

  @override
  Future<Response<T>> broadcast<T>(ApiRequestModel<BroadcastReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.post<T>(
        body: apiRequestModel.requestData.toJson(),
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/txs',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch broadcast() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryAccount<T>(ApiRequestModel<QueryAccountReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/accounts/${apiRequestModel.requestData.address}',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryAccount() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(ApiRequestModel<QueryBalanceReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/balances/${apiRequestModel.requestData.address}',
        queryParameters: apiRequestModel.requestData.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryBalance() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryDelegations<T>(ApiRequestModel<QueryDelegationsReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/delegations',
        queryParameters: apiRequestModel.requestData.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryDelegations() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryExecutionFee<T>(ApiRequestModel<QueryExecutionFeeRequest> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/execution_fee',
        queryParameters: apiRequestModel.requestData.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryDelegations() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(ApiRequestModel<String> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/identity_records/${apiRequestModel.requestData}',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryIdentityRecordsByAddress() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordById<T>(ApiRequestModel<String> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/identity_record/${apiRequestModel.requestData}',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryIdentityRecordById() for URI ${apiRequestModel.networkUri}: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      ApiRequestModel<QueryIdentityRecordVerifyRequestsByApproverReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_approver/${apiRequestModel.requestData.address}',
        queryParameters: apiRequestModel.requestData.queryParameters,
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(
        message: 'Cannot fetch fetchQueryIdentityRecordVerifyRequestsByApprover() for URI ${apiRequestModel.networkUri}: ${dioException.message}',
      );
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      ApiRequestModel<QueryIdentityRecordVerifyRequestsByRequesterReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_requester/${apiRequestModel.requestData.address}',
        queryParameters: apiRequestModel.requestData.queryParameters,
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(
        message: 'Cannot fetch fetchQueryIdentityRecordVerifyRequestsByRequester() for URI ${apiRequestModel.networkUri}: ${dioException.message}',
      );
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(ApiRequestModel<void> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/tokens/aliases',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryKiraTokensAliases() for URI ${apiRequestModel.networkUri} ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(ApiRequestModel<void> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/tokens/rates',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryKiraTokensRates() for URI ${apiRequestModel.networkUri} ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryNetworkProperties<T>(ApiRequestModel<void> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/gov/network_properties',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryNetworkProperties() for URI ${apiRequestModel.networkUri} ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryStakingPool<T>(ApiRequestModel<QueryStakingPoolReq> apiRequestModel) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: apiRequestModel.networkUri,
        path: '/api/kira/staking-pool',
        queryParameters: apiRequestModel.requestData.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'Cannot fetch fetchQueryStakingPool() for URI ${apiRequestModel.networkUri} ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }
}
