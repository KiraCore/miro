import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';

abstract class _QueryBalanceService {
  Future<QueryBalanceResp?> getMyAccountBalance({Uri? optionalNetworkUri});

  Future<QueryBalanceResp?> getAccountBalance(QueryBalanceReq queryBalanceReq, {Uri? optionalNetworkUri});
}

class QueryBalanceService implements _QueryBalanceService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryBalanceResp?> getMyAccountBalance({Uri? optionalNetworkUri}) async {
    QueryBalanceReq queryBalanceReq = QueryBalanceReq(
      address: globalLocator<WalletProvider>().currentWallet!.address.bech32Address,
    );
    return await getAccountBalance(queryBalanceReq, optionalNetworkUri: optionalNetworkUri);
  }

  @override
  Future<QueryBalanceResp?> getAccountBalance(QueryBalanceReq queryBalanceReq, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final Response<dynamic> response =
          await _apiCosmosRepository.fetchQueryBalance<dynamic>(networkUri, queryBalanceReq);
      return QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }
}
