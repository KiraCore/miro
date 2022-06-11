import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_request_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_record_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/request/query_identity_records_by_address_req.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/test/mocks/api_kira/api_kira_identity_record.dart';
import 'package:miro/test/mocks/api_kira/api_kira_identity_records.dart';
import 'package:miro/test/mocks/api_kira/api_kira_identity_verify_record.dart';
import 'package:miro/test/mocks/api_kira/api_kira_identity_verify_requests_by_approver.dart';
import 'package:miro/test/mocks/api_kira/api_kira_identity_verify_requests_by_requester.dart';
import 'package:miro/test/mocks/api_kira/api_kira_tokens_aliases.dart';
import 'package:miro/test/mocks/api_kira/api_kira_tokens_rates.dart';

class MockApiKiraRepository implements ApiKiraRepository {
  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
    return Response<T>(
      statusCode: 200,
      data: apiKiraTokensAliases as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
    return Response<T>(
      statusCode: 200,
      data: apiKiraTokensRates as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecord<T>(Uri networkUri, QueryIdentityRecordReq queryIdentityRecordReq) async {
    return Response<T>(
      statusCode: 200,
      data: apiKiraIdentityRecord as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(
      Uri networkUri, QueryIdentityRecordsByAddressReq queryIdentityRecordsByAddressReq) async {
    return Response<T>(
      statusCode: 200,
      data: apiKiraIdentityRecords as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequest<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestReq queryIdentityRecordVerifyRequestReq) async {
    return Response<T>(
      statusCode: 200,
      data: identityVerifyRecord as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq) async {
    return Response<T>(
      statusCode: 200,
      data: identityVerifyRequestsByApprover as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      Uri networkUri, QueryIdentityRecordVerifyRequestsReq queryIdentityRecordVerifyRequestsReq) async {
    return Response<T>(
      statusCode: 200,
      data: identityVerifyRequestsByRequester as T,
      requestOptions: RequestOptions(path: ''),
    );
  }
}
