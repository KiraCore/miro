import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';

abstract class _QueryBalanceService {
  Future<QueryBalanceResp?> getAccountBalance(Uri networkUri, QueryBalanceReq queryBalanceReq);

  void ignoreMethod();
}

class QueryBalanceService implements _QueryBalanceService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryBalanceResp?> getAccountBalance(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    try {
      final Response<dynamic> response = await _apiCosmosRepository.fetchQueryBalance<dynamic>(networkUri, queryBalanceReq);
      return QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(Karol): implement ignoreMethod
  }
}
