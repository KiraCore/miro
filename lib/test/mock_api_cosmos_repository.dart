import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/test/mocks/api/api_balances.dart';

class MockApiCosmosRepository implements ApiCosmosRepository {
  @override
  Future<BroadcastResp> broadcast(Uri networkUri, BroadcastReq request) {
    // TODO(Dominik): implement broadcastCosmosTransaction
    throw UnimplementedError();
  }

  @override
  Future<QueryAccountResp> fetchQueryAccount(Uri networkUri, QueryAccountReq request) {
    // TODO(Dominik): implement fetchAuthAccount
    throw UnimplementedError();
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    int statusCode = 404;
    Map<String, dynamic>? mockedResponse;

    if (networkUri.host == 'unhealthy.kira.network') {
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
}
