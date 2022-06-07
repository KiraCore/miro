import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/providers/wallet_provider.dart';

abstract class _QueryBalanceService {
  Future<QueryBalanceResp?> getMyAccountBalance();

  Future<QueryBalanceResp?> getAccountBalance(Uri networkUri, QueryBalanceReq queryBalanceReq);
}

class QueryBalanceService implements _QueryBalanceService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryBalanceResp?> getMyAccountBalance() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    QueryBalanceReq queryBalanceReq = QueryBalanceReq(
      address: globalLocator<WalletProvider>().currentWallet!.address.bech32Address,
    );
    return await getAccountBalance(networkUri, queryBalanceReq);
  }

  @override
  Future<QueryBalanceResp?> getAccountBalance(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    try {
      final Response<dynamic> response = await _apiCosmosRepository.fetchQueryBalance<dynamic>(networkUri, queryBalanceReq);
      return QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }
}
