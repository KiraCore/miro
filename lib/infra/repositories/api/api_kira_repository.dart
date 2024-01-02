import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests_by_requester/request/query_identity_record_verify_requests_by_requester_resp.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/managers/api/http_client_manager.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class IApiKiraRepository {
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request);

  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request);

  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq);

  Future<Response<T>> fetchQueryExecutionFee<T>(Uri networkUri, QueryExecutionFeeRequest queryExecutionFeeRequest);

  Future<Response<T>> fetchQueryGovernanceProposals<T>(Uri networkUri);

  Future<Response<T>> fetchQueryGovernanceProposal<T>(Uri networkUri, int proposalId);

  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(Uri networkUri, String creator);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(Uri networkUri, QueryIdentityRecordVerifyRequestsByRequesterReq queryIdentityRecordVerifyRequestsByRequesterReq);

  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri);

  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri);

  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri);

  Future<Response<T>> fetchQueryVoters<T>(Uri networkUri, int proposalId);
  Future<Response<T>> fetchQueryVotes<T>(Uri networkUri, int proposalId);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch broadcast for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryAccount() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryBalance() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryExecutionFee for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryGovernanceProposals<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/proposals',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryGovernanceProposals() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryGovernanceProposal<T>(Uri networkUri, int proposalId) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/proposals/$proposalId',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryGovernanceProposal() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordsByAddress() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(Uri networkUri, QueryIdentityRecordVerifyRequestsByRequesterReq queryIdentityRecordVerifyRequestsByRequesterReq) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_requester/${queryIdentityRecordVerifyRequestsByRequesterReq.address}',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(
        message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryIdentityRecordVerifyRequestsByRequester() for URI $networkUri: ${dioError.message}',
      );
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryKiraTokensAliases() for URI $networkUri ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryKiraTokensRates() for URI $networkUri ${dioError.message}');
      throw DioConnectException(dioError: dioError);
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
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryNetworkProperties() for URI $networkUri ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryVoters<T>(Uri networkUri, int proposalId) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/voters/$proposalId',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryGovernanceProposal() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }

  @override
  Future<Response<T>> fetchQueryVotes<T>(Uri networkUri, int proposalId) async {
    try {
      final Response<T> response = await _httpClientManager.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/votes/$proposalId',
      );
      return response;
    } on DioError catch (dioError) {
      AppLogger().log(message: 'RemoteApiKiraRepository: Cannot fetch fetchQueryGovernanceProposal() for URI $networkUri: ${dioError.message}');
      throw DioConnectException(dioError: dioError);
    }
  }
}
