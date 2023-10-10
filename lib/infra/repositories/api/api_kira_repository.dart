import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_requester_req.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/request/query_staking_pool_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/managers/api/http_client_manager.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class IApiKiraRepository {
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request);

  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request);

  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq);

  Future<Response<T>> fetchQueryExecutionFee<T>(Uri networkUri, QueryExecutionFeeRequest queryExecutionFeeRequest);

  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(Uri networkUri, String creator);

  Future<Response<T>> fetchQueryIdentityRecordById<T>(Uri networkUri, String id);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsByApproverReq queryIdentityRecordVerifyRequestsByApproverReq);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsByRequesterReq queryIdentityRecordVerifyRequestsByRequesterReq);

  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri);

  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri);

  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri);

  Future<Response<T>> fetchQueryStakingPool<T>(Uri networkUri, QueryStakingPoolReq queryStakingPoolReq);
}

class RemoteApiKiraRepository implements IApiKiraRepository {
  final HttpClientManager _httpClientManager = HttpClientManager();

  @override
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request) async {
    try {
      final Response<T> response = await _httpClientManager.post<T>(
        body: request.toJson(),
        networkUri: networkUri,
        path: '/api/kira/txs',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch broadcast for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/accounts/${request.address}',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryAccount() for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/balances/${queryBalanceReq.address}',
        queryParameters: queryBalanceReq.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryBalance() for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryExecutionFee<T>(Uri networkUri, QueryExecutionFeeRequest queryExecutionFeeRequest) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/execution_fee',
        queryParameters: queryExecutionFeeRequest.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryExecutionFee for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(Uri networkUri, String creator) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_records/$creator',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordsByAddress() for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordById<T>(Uri networkUri, String id) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_record/$id',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordById() for URI $networkUri: ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsByApproverReq queryIdentityRecordVerifyRequestsByApproverReq) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_approver/${queryIdentityRecordVerifyRequestsByApproverReq.address}',
        queryParameters: queryIdentityRecordVerifyRequestsByApproverReq.queryParameters,
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(
        message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordVerifyRequestsByApprover() for URI $networkUri: ${dioException.message}',
      );
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsByRequesterReq queryIdentityRecordVerifyRequestsByRequesterReq) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_requester/${queryIdentityRecordVerifyRequestsByRequesterReq.address}',
        queryParameters: queryIdentityRecordVerifyRequestsByRequesterReq.queryParameters,
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(
        message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordVerifyRequestsByRequester() for URI $networkUri: ${dioException.message}',
      );
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/aliases',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryKiraTokensAliases() for URI $networkUri ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/rates',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryKiraTokensRates() for URI $networkUri ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/network_properties',
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryNetworkProperties() for URI $networkUri ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }

  @override
  Future<Response<T>> fetchQueryStakingPool<T>(Uri networkUri, QueryStakingPoolReq queryStakingPoolReq) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/staking-pool',
        queryParameters: queryStakingPoolReq.toJson(),
      );
      return response;
    } on DioException catch (dioException) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryStakingPool() for URI $networkUri ${dioException.message}');
      throw DioConnectException(dioException: dioException);
    }
  }
}
