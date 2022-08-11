import 'package:dio/dio.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_aliases.dart';
import 'package:miro/test/mocks/api_kira/mock_api_kira_tokens_rates.dart';

class MockApiKiraRepository implements ApiKiraRepository {
  static List<String> workingEndpoints = <String>['unhealthy.kira.network', 'healthy.kira.network'];

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
    bool hasResponse = workingEndpoints.contains(networkUri.host);
    if (hasResponse) {
      return Response<T>(
        statusCode: 200,
        data: MockApiKiraTokensAliases.defaultResponse as T,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioError(requestOptions: RequestOptions(path: networkUri.host));
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
    bool hasResponse = workingEndpoints.contains(networkUri.host);
    if (hasResponse) {
      return Response<T>(
        statusCode: 200,
        data: MockApiKiraTokensRates.defaultResponse as T,
        requestOptions: RequestOptions(path: ''),
      );
    } else {
      throw DioError(requestOptions: RequestOptions(path: networkUri.host));
    }
  }
}
