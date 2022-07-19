import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IQueryBalanceService {
  /// Throws [DioError]
  Future<QueryBalanceResp?> getQueryBalanceResp(QueryBalanceReq queryBalanceReq, {Uri? optionalNetworkUri});
}

class QueryBalanceService implements _IQueryBalanceService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryBalanceResp?> getQueryBalanceResp(QueryBalanceReq queryBalanceReq, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiCosmosRepository.fetchQueryBalance<dynamic>(
      networkUri,
      queryBalanceReq,
    );
    return QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
  }
}
