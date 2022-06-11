import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_request_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_request_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_requests_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/identity_registrar/verify_request_model.dart';

abstract class _IQueryIdentityVerifyRequestsService {
  Future<VerifyRequestModel> getVerifyRequestModel(
    String requestId, {
    Uri? optionalNetworkUri,
  });

  Future<VerifyRequestModel> getVerifyRequestModelByApprover(
    String approverAddress, {
    Uri? optionalNetworkUri,
  });

  Future<VerifyRequestModel> getVerifyRequestModelByRequester(
    String requesterAddress, {
    Uri? optionalNetworkUri,
  });

  Future<QueryIdentityRecordVerifyRequestResp> getQueryIdentityRecordVerifyRequestResp(
    String requestId, {
    Uri? optionalNetworkUri,
  });

  Future<QueryIdentityRecordVerifyRequestsResp> getQueryIdentityRecordVerifyRequestsRespByApprover(
    String approverAddress, {
    Uri? optionalNetworkUri,
  });

  Future<QueryIdentityRecordVerifyRequestsResp> getQueryIdentityRecordVerifyRequestsRespByRequester(
    String requesterAddress, {
    Uri? optionalNetworkUri,
  });
}

class QueryIdentityVerifyRequestsService implements _IQueryIdentityVerifyRequestsService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<VerifyRequestModel> getVerifyRequestModel(
    String requestId, {
    Uri? optionalNetworkUri,
  }) async {
    final QueryIdentityRecordVerifyRequestResp queryIdentityRecordVerifyRequestResp =
        await getQueryIdentityRecordVerifyRequestResp(
      requestId,
      optionalNetworkUri: optionalNetworkUri,
    );
    return VerifyRequestModel.fromDto(queryIdentityRecordVerifyRequestResp.verifyRecord);
  }

  @override
  Future<VerifyRequestModel> getVerifyRequestModelByApprover(
    String approverAddress, {
    Uri? optionalNetworkUri,
  }) async {
    final QueryIdentityRecordVerifyRequestsResp queryIdentityRecordVerifyRequestsResp =
        await getQueryIdentityRecordVerifyRequestsRespByApprover(
      approverAddress,
      optionalNetworkUri: optionalNetworkUri,
    );
    return VerifyRequestModel.fromDto(queryIdentityRecordVerifyRequestsResp.verifyRecords.first);
  }

  @override
  Future<VerifyRequestModel> getVerifyRequestModelByRequester(
    String requesterAddress, {
    Uri? optionalNetworkUri,
  }) async {
    final QueryIdentityRecordVerifyRequestsResp queryIdentityRecordVerifyRequestsResp =
        await getQueryIdentityRecordVerifyRequestsRespByRequester(
      requesterAddress,
      optionalNetworkUri: optionalNetworkUri,
    );
    return VerifyRequestModel.fromDto(queryIdentityRecordVerifyRequestsResp.verifyRecords.first);
  }

  @override
  Future<QueryIdentityRecordVerifyRequestResp> getQueryIdentityRecordVerifyRequestResp(
    String requestId, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequest<dynamic>(
      networkUri,
      QueryIdentityRecordVerifyRequestReq(
        requestId: requestId,
      ),
    );
    return QueryIdentityRecordVerifyRequestResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<QueryIdentityRecordVerifyRequestsResp> getQueryIdentityRecordVerifyRequestsRespByApprover(
    String approverAddress, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response =
        await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequestsByApprover<dynamic>(
      networkUri,
      QueryIdentityRecordVerifyRequestsReq(
        address: approverAddress,
      ),
    );
    return QueryIdentityRecordVerifyRequestsResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<QueryIdentityRecordVerifyRequestsResp> getQueryIdentityRecordVerifyRequestsRespByRequester(
    String requesterAddress, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response =
        await _apiKiraRepository.fetchQueryIdentityRecordVerifyRequestsByRequester<dynamic>(
      networkUri,
      QueryIdentityRecordVerifyRequestsReq(
        address: requesterAddress,
      ),
    );
    return QueryIdentityRecordVerifyRequestsResp.fromJson(response.data as Map<String, dynamic>);
  }
}
