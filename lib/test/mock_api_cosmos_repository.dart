import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/test/mocks/api/api_balances.dart';

class MockApiCosmosRepository implements ApiCosmosRepository {
  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;

    if (networkUri.host == 'online.kira.network') {
      statusCode = 200;
      mockedResponse = apiBalancesMock;
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
  void ignore() {
    // TODO(Karol): implement ignore
  }
}
