import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';

class MockApiCosmosRepository implements ApiCosmosRepository {
  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) {
    // TODO(Karol): implement fetchQueryBalance
    throw UnimplementedError();
  }

  @override
  void ignore() {
    // TODO(Karol): implement ignore
  }
}