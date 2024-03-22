import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryBalanceService {
  Future<List<BalanceModel>> getBalancesByTokenNames(String address, List<String> tokenNames);

  Future<PageData<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq);
}

class QueryBalanceService implements _IQueryBalanceService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();
  final QueryKiraTokensAliasesService _queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  @override
  Future<List<BalanceModel>> getBalancesByTokenNames(String address, List<String> tokenNames) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    if (tokenNames.isEmpty) {
      return List<BalanceModel>.empty(growable: true);
    }

    Response<dynamic> response = await _apiKiraRepository.fetchQueryBalance<dynamic>(ApiRequestModel<QueryBalanceReq>(
      networkUri: networkUri,
      requestData: QueryBalanceReq(
        address: address,
        tokens: tokenNames,
      ),
    ));

    try {
      QueryBalanceResp queryBalanceResp = QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
      List<BalanceModel> balanceModelList = await _buildBalanceModels(queryBalanceResp);
      return balanceModelList;
    } catch (e) {
      AppLogger().log(message: 'QueryBalanceService: Cannot parse getBalanceByToken() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<PageData<BalanceModel>> getBalanceModelList(QueryBalanceReq queryBalanceReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiKiraRepository.fetchQueryBalance<dynamic>(ApiRequestModel<QueryBalanceReq>(
      networkUri: networkUri,
      requestData: queryBalanceReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryBalanceResp queryBalanceResp = QueryBalanceResp.fromJson(response.data as Map<String, dynamic>);
      List<BalanceModel> balanceModelList = await _buildBalanceModels(queryBalanceResp);

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<BalanceModel>(
        listItems: balanceModelList,
        lastPageBool: balanceModelList.length < queryBalanceReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryBalanceService: Cannot parse getBalanceModelList() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  Future<List<BalanceModel>> _buildBalanceModels(QueryBalanceResp queryBalanceResp) async {
    List<BalanceModel> rawBalanceModelList = queryBalanceResp.balances.map(BalanceModel.fromDto).toList();

    List<String> involvedTokenNames = rawBalanceModelList.map((BalanceModel balanceModel) => balanceModel.defaultDenomName).toList();
    List<TokenAliasModel> involvedTokenAliases = await _queryKiraTokensAliasesService.getAliasesByTokenNames(involvedTokenNames);

    List<BalanceModel> filledBalanceModelList = rawBalanceModelList.map((BalanceModel e) => e.fillTokenAlias(involvedTokenAliases)).toList();
    return filledBalanceModelList;
  }
}
