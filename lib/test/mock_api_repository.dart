import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/test/mocks/api/mock_api_dashboard.dart';
import 'package:miro/test/mocks/api/mock_api_status.dart';
import 'package:miro/test/mocks/api/mock_api_valopers.dart';

enum DynamicNetworkStatus {
  healthy,
  unhealthy,
  offline,
}

class MockApiRepository implements IApiRepository {
  static List<String> workingEndpoints = <String>[
    'unhealthy.kira.network',
    'custom-unhealthy.kira.network',
    'healthy.kira.network',
    'custom-healthy.kira.network',
    'invalid.kira.network',
  ];

  DynamicNetworkStatus dynamicNetworkStatus = DynamicNetworkStatus.healthy;

  @override
  Future<Response<T>> fetchDashboard<T>(Uri networkUri) async {
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (responseExistsBool) {
      late T response;
      switch (networkUri.host) {
        case 'invalid.kira.network':
          response = <String, dynamic>{'invalid': 'response'} as T;
          break;
        default:
          response = MockApiDashboard.defaultResponse as T;
          break;
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
  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;
    await Future<void>.delayed(const Duration(milliseconds: 50));

    switch (networkUri.host) {
      case 'invalid.kira.network':
        statusCode = 200;
        mockedResponse = <String, dynamic>{'invalid': 'response'};
        break;
      case 'unhealthy.kira.network':
      case 'custom-unhealthy.kira.network':
        statusCode = 200;
        mockedResponse = MockApiStatus.unhealthyResponse;
        break;
      case 'healthy.kira.network':
      case 'custom-healthy.kira.network':
        statusCode = 200;
        mockedResponse = MockApiStatus.healthyResponse;
        break;
      case 'dynamic.kira.network':
        if (dynamicNetworkStatus == DynamicNetworkStatus.healthy) {
          statusCode = 200;
          mockedResponse = MockApiStatus.healthyResponse;
          dynamicNetworkStatus = DynamicNetworkStatus.unhealthy;
        } else if (dynamicNetworkStatus == DynamicNetworkStatus.unhealthy) {
          statusCode = 200;
          mockedResponse = MockApiStatus.unhealthyResponse;
          dynamicNetworkStatus = DynamicNetworkStatus.offline;
        } else {
          statusCode = 404;
          mockedResponse = null;
          dynamicNetworkStatus = DynamicNetworkStatus.healthy;
        }
        break;
    }

    if (statusCode == 404) {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }

    return Response<T>(
      statusCode: statusCode,
      data: mockedResponse as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq) async {
    bool responseExistsBool = workingEndpoints.contains(networkUri.host);
    if (networkUri.host == 'invalid.kira.network') {
      return Response<T>(
        statusCode: 200,
        data: <String, dynamic>{'invalid': 'response'} as T,
        requestOptions: RequestOptions(path: ''),
      );
    } else if (responseExistsBool && queryValidatorsReq.limit != null && queryValidatorsReq.offset != null) {
      return _fetchQueryValidatorsPaginated<T>(queryValidatorsReq);
    } else if (responseExistsBool && queryValidatorsReq.statusOnly == true) {
      if (networkUri.host == 'unhealthy.kira.network') {
        throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
      }
      return Response<T>(
        statusCode: 200,
        data: MockApiValopers.statusOnly as T,
        requestOptions: RequestOptions(path: ''),
      );
    } else if (responseExistsBool) {
      return Response<T>(
        statusCode: 200,
        data: MockApiValopers.all as T,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioConnectException(dioError: DioError(requestOptions: RequestOptions(path: networkUri.host)));
    }
  }

  Future<Response<T>> _fetchQueryValidatorsPaginated<T>(QueryValidatorsReq queryValidatorsReq) async {
    late Map<String, dynamic> mockedResponse;

    List<dynamic> mockedResponseList = MockApiValopers.all['validators'] as List<dynamic>;
    if (queryValidatorsReq.offset == '0' && queryValidatorsReq.limit == '2') {
      mockedResponse = <String, dynamic>{
        'validators': mockedResponseList.sublist(0, 2),
      };
    } else if (queryValidatorsReq.offset == '0' && queryValidatorsReq.limit == '500') {
      mockedResponse = <String, dynamic>{
        'validators': mockedResponseList.sublist(0, 3),
      };
    } else {
      mockedResponse = <String, dynamic>{
        'validators': mockedResponseList.sublist(0, 3),
      };
    }
    return Response<T>(
      statusCode: 200,
      data: mockedResponse as T,
      requestOptions: RequestOptions(path: ''),
    );
  }
}
