import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiCosmosRepository {
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq);

  void ignore();
}

class RemoteApiCosmosRepository implements ApiCosmosRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    try {
      final Response<T> response = await _api.get<T>(
          networkUri: networkUri,
          path: '/api/cosmos/bank/balances/${queryBalanceReq.address}',
          queryParameters: queryBalanceReq.toJson(),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignore() {
  }

}