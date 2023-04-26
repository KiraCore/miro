import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryBalanceService {
  Future<List<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq);
}

class QueryBalanceService implements _IQueryBalanceService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

    List<TokenAliasModel> tokenAliasModels = await queryKiraTokensAliasesService.getTokenAliasModels();
    Response<dynamic> response = await _apiKiraRepository.fetchQueryBalance<dynamic>(networkUri, queryBalanceReq);

    try {
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
    } catch (e) {
      AppLogger().log(message: 'QueryBalanceService: Cannot parse getBalanceModelList() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
