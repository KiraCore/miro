import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/test/mocks/api/api_dashboard.dart';
import 'package:miro/test/mocks/api/api_query_validators.dart';
import 'package:miro/test/mocks/api/api_status.dart';

enum DynamicNetworkStatus {
  healthy,
  unhealthy,
  offline,
}

class MockApiRepository implements ApiRepository {
  DynamicNetworkStatus dynamicNetworkStatus = DynamicNetworkStatus.healthy;

  @override
  Future<Response<T>> fetchQueryInterxStatus<T>(Uri networkUri) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;
    await Future<void>.delayed(const Duration(milliseconds: 50));

    switch (networkUri.host) {
      case 'unhealthy.kira.network':
        statusCode = 200;
        mockedResponse = apiStatusMockUnhealthy;
        break;
      case 'healthy.kira.network':
        statusCode = 200;
        mockedResponse = apiStatusMockHealthy;
        break;
      case 'dynamic.kira.network':
        if (dynamicNetworkStatus == DynamicNetworkStatus.healthy) {
          statusCode = 200;
          mockedResponse = apiStatusMockHealthy;
          dynamicNetworkStatus = DynamicNetworkStatus.unhealthy;
        } else if (dynamicNetworkStatus == DynamicNetworkStatus.unhealthy) {
          statusCode = 200;
          mockedResponse = apiStatusMockUnhealthy;
          dynamicNetworkStatus = DynamicNetworkStatus.offline;
        } else {
          statusCode = 404;
          mockedResponse = null;
          dynamicNetworkStatus = DynamicNetworkStatus.healthy;
        }
        break;
    }

    if (statusCode == 404) {
      throw DioError(requestOptions: RequestOptions(path: networkUri.host));
    }

    return Response<T>(
      statusCode: statusCode,
      data: mockedResponse as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchDeposits<T>(Uri networkUri, DepositsReq depositsReq) {
    // TODO(Karol): implement fetchDeposits
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> fetchWithdraws<T>(Uri networkUri, WithdrawsReq withdrawsReq) {
    // TODO(Karol): implement fetchWithdraws
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> fetchQueryValidators<T>(Uri networkUri, QueryValidatorsReq queryValidatorsReq) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;

    if (networkUri.host == 'unhealthy.kira.network') {
      statusCode = 200;
      if (queryValidatorsReq.limit != null && queryValidatorsReq.offset != null) {
        List<dynamic> mockedResponseList = apiValidatorsMock['validators'] as List<dynamic>;
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
      } else {
        mockedResponse = apiValidatorsMock;
      }
    } else {
      throw DioError(requestOptions: RequestOptions(path: networkUri.host));
    }

    return Response<T>(
      statusCode: statusCode,
      data: mockedResponse as T,
      requestOptions: RequestOptions(path: ''),
    );
  }

  @override
  Future<Response<T>> fetchDashboard<T>(Uri networkUri) async {
    return Response<T>(
      statusCode: 200,
      data: apiDashboardMock as T,
      requestOptions: RequestOptions(path: ''),
    );
  }
}
