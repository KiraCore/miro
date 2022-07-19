import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IQueryAccountService {
  /// Throws [DioError]
  Future<QueryAccountResp> getQueryAccountResp(String address, {Uri? optionalNetworkUri});
}

class QueryAccountService implements _IQueryAccountService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryAccountResp> getQueryAccountResp(String address, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    Response<dynamic> response = await _apiCosmosRepository.fetchQueryAccount<dynamic>(
      networkUri,
      QueryAccountReq(address: address),
    );
    return QueryAccountResp.fromJson(response.data as Map<String, dynamic>);
  }
}
