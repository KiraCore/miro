import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_requester_req.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/request/query_proposals_req.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/request/query_staking_pool_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_accounts.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_balances.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_delegations.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_gov_execution_fee.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_gov_network_properties.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_identity_record_by_id.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_identity_records.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_identity_verify_requests_by_approver.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_identity_verify_requests_by_requester.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_proposals.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_staking_pool.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_aliases.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_rates.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_txs.dart';
import 'package:miro/test/mocks/mock_headers.dart';

class MockApiKiraRepository implements IApiKiraRepository {
  static List<String> workingEndpoints = <String>[
    'custom-healthy.kira.network',
    'custom-unhealthy.kira.network',
    'unhealthy.kira.network',
    'healthy.kira.network',
    'invalid.kira.network',
  ];

  @override
  Future<Response<T>> broadcast<T>(ApiRequestModel<BroadcastReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'unhealthy.kira.network':
          response = MockApiKiraTxs.dioParseExceptionResponse as T;
          break;
        case 'custom-unhealthy.kira.network':
          response = MockApiKiraTxs.txBroadcastExceptionResponse as T;
          break;
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraTxs.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryAccount<T>(ApiRequestModel<QueryAccountReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      late int statusCode;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          statusCode = 404;
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        case 'unhealthy.kira.network':
          statusCode = 404;
          response = MockApiKiraAccounts.defaultResponse as T;
          break;
        default:
          statusCode = 200;
          response = MockApiKiraAccounts.defaultResponse as T;
      }
      return Response<T>(
        statusCode: statusCode,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(ApiRequestModel<QueryBalanceReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraBalances.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryDelegations<T>(ApiRequestModel<QueryDelegationsReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraDelegations.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryExecutionFee<T>(ApiRequestModel<QueryExecutionFeeRequest> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          Map<String, dynamic> defaultResponse = MockApiKiraGovExecutionFee.defaultResponse;
          defaultResponse['transaction_type'] = apiRequestModel.requestData.message;
          response = defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryProposals<T>(ApiRequestModel<QueryProposalsReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraProposals.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordsByAddress<T>(ApiRequestModel<String> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraIdentityRecords.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordById<T>(ApiRequestModel<String> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraIdentityRecordById.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByApprover<T>(
      ApiRequestModel<QueryIdentityRecordVerifyRequestsByApproverReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraIdentityVerifyRequestsByApprover.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryIdentityRecordVerifyRequestsByRequester<T>(
      ApiRequestModel<QueryIdentityRecordVerifyRequestsByRequesterReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraIdentityVerifyRequestsByRequester.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(ApiRequestModel<void> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraTokensAliases.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(ApiRequestModel<void> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraTokensRates.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryNetworkProperties<T>(ApiRequestModel<void> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraGovNetworkProperties.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryStakingPool<T>(ApiRequestModel<QueryStakingPoolReq> apiRequestModel) async {
    Uri networkUri = apiRequestModel.networkUri;
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraStakingPool.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockHeaders.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioException: DioException(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }
}
