import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_request_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_record_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_records_by_address_req.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiKiraRepository {
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri);

  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri);

  Future<Response<T>> fetchQueryIdentityRecord<T>(Uri networkUri, QueryIdentityRecordReq queryIdentityRecordReq);

  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(
      Uri networkUri, QueryIdentityRecordsByAddressReq queryIdentityRecordsByAddressReq);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequest<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestReq queryIdentityRecordVerifyRequestReq);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq);

  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq);
}

class RemoteApiKiraRepository implements ApiKiraRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/aliases',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/rates',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecord<T>(Uri networkUri, QueryIdentityRecordReq queryIdentityRecordReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_record/${queryIdentityRecordReq.id}',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(
      Uri networkUri, QueryIdentityRecordsByAddressReq queryIdentityRecordsByAddressReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_records/${queryIdentityRecordsByAddressReq.creator}',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequest<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestReq queryIdentityRecordVerifyRequestReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_record/${queryIdentityRecordVerifyRequestReq.requestId}',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_approver/${queryIdentityRecordVerifyRequestsReq.address}',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/identity_verify_requests_by_requester/${queryIdentityRecordVerifyRequestsReq.address}',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
