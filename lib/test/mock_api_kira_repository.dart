import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_kira/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_accounts.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_balances.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_gov_execution_fee.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_gov_network_properties.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_aliases.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_rates.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_txs.dart';

class MockApiKiraRepository implements IApiKiraRepository {
  static List<String> workingEndpoints = <String>[
    'custom-healthy.kira.network',
    'custom-unhealthy.kira.network',
    'unhealthy.kira.network',
    'healthy.kira.network',
    'invalid.kira.network',
  ];

  @override
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request) async {
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
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request) async {
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiKiraAccounts.defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        headers: MockApiKiraAccounts.defaultHeaders,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
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
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryExecutionFee<T>(Uri networkUri, QueryExecutionFeeRequest queryExecutionFeeRequest) async {
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          Map<String, dynamic> defaultResponse = MockApiKiraGovExecutionFee.defaultResponse;
          defaultResponse['transaction_type'] = queryExecutionFeeRequest.message;
          response = defaultResponse as T;
      }
      return Response<T>(
        statusCode: 200,
        data: response,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
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
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
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
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  @override
  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri) async {
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
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }
}
