import 'package:dio/dio.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
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
}
