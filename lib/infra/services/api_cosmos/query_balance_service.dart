import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

abstract class _IQueryBalanceService {
  Future<List<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq);
}

class QueryBalanceService implements _IQueryBalanceService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<List<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

    List<TokenAliasModel> tokenAliasModels = await queryKiraTokensAliasesService.getTokenAliasModels();

    final Response<dynamic> response = await _apiCosmosRepository.fetchQueryBalance<dynamic>(
      networkUri,
      queryBalanceReq,
    );
    QueryBalanceResp queryBalanceResp = QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);

    List<BalanceModel> balanceModelList = List<BalanceModel>.empty(growable: true);
    for (Balance balance in queryBalanceResp.balances) {
      TokenAliasModel tokenAliasModel = tokenAliasModels.firstWhere((TokenAliasModel e) {
        return e.lowestTokenDenominationModel.name == balance.denom;
      }, orElse: () => TokenAliasModel.local(balance.denom));

      TokenAmountModel tokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.parse(balance.amount),
        tokenAliasModel: tokenAliasModel,
      );
      balanceModelList.add(BalanceModel(tokenAmountModel: tokenAmountModel));
    }
    return balanceModelList;
  }
}
