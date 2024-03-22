import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/request/query_kira_tokens_aliases_req.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/memory/token_aliases_memory.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryKiraTokensAliasesService {
  Future<List<TokenAliasModel>> getAliasesByTokenNames(List<String> tokenNames, {Uri? networkUri});

  Future<TokenDefaultDenomModel> getTokenDefaultDenomModel(Uri networkUri);
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<TokenAliasModel>> getAliasesByTokenNames(List<String> tokenNames, {Uri? networkUri}) async {
    if (tokenNames.isEmpty) {
      return List<TokenAliasModel>.empty();
    }

    networkUri ??= globalLocator<NetworkModuleBloc>().state.networkUri;
    List<TokenAliasModel> tokenAliasModelList = List<TokenAliasModel>.empty(growable: true);

    List<TokenAliasModel> cachedTokenAliasModels = globalLocator<TokenAliasesMemory>().getTokenAliasesByNames(tokenNames, networkUri);
    tokenAliasModelList.addAll(cachedTokenAliasModels);

    if (tokenAliasModelList.length != tokenNames.length) {
      List<String> tokensToQuery = _getRemainingTokens(tokenNames, tokenAliasModelList);
      List<TokenAliasModel> tokenAliasModelsFromInterx = await _getAliasesFromInterx(tokensToQuery, networkUri: networkUri);
      tokenAliasModelList.addAll(tokenAliasModelsFromInterx);
    }

    if (tokenAliasModelList.length != tokenNames.length) {
      List<String> localTokens = _getRemainingTokens(tokenNames, tokenAliasModelList);
      for (String localToken in localTokens) {
        tokenAliasModelList.add(TokenAliasModel.local(localToken));
      }
    }

    return tokenAliasModelList;
  }

  @override
  Future<TokenDefaultDenomModel> getTokenDefaultDenomModel(Uri networkUri, {bool forceRequestBool = false}) async {
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(ApiRequestModel<QueryKiraTokensAliasesReq>(
      networkUri: networkUri,
      // get only "default_denom" and "bech32_prefix", 0 records in "token_aliases_data" for quicker response
      requestData: const QueryKiraTokensAliasesReq(offset: 0, limit: 0),
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJson(response.data as Map<String, dynamic>);
      TokenAliasModel defaultTokenAliasModel = await _getAliasByTokenName(queryKiraTokensAliasesResp.defaultDenom, networkUri: networkUri);
      TokenDefaultDenomModel tokenDefaultDenomModel = TokenDefaultDenomModel(
        valuesFromNetworkExistBool: true,
        bech32AddressPrefix: queryKiraTokensAliasesResp.bech32Prefix,
        defaultTokenAliasModel: defaultTokenAliasModel,
      );

      return tokenDefaultDenomModel;
    } catch (e) {
      return TokenDefaultDenomModel.empty();
    }
  }

  Future<List<TokenAliasModel>> _getAliasesFromInterx(List<String> tokenNames, {Uri? networkUri}) async {
    networkUri ??= globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(ApiRequestModel<QueryKiraTokensAliasesReq>(
      networkUri: networkUri,
      requestData: QueryKiraTokensAliasesReq(tokens: tokenNames),
    ));

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJson(response.data as Map<String, dynamic>);
      List<TokenAliasModel> tokenAliasModelList = queryKiraTokensAliasesResp.tokenAliases.map(TokenAliasModel.fromDto).toList();
      globalLocator<TokenAliasesMemory>().saveResponse(tokenAliasModelList, networkUri);
      return tokenAliasModelList;
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensAliasesService: Cannot parse getAliasesFromInterx() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  Future<TokenAliasModel> _getAliasByTokenName(String tokenName, {Uri? networkUri}) async {
    networkUri ??= globalLocator<NetworkModuleBloc>().state.networkUri;

    List<TokenAliasModel> tokenAliasModels = await getAliasesByTokenNames(<String>[tokenName], networkUri: networkUri);
    return tokenAliasModels.firstOrNull ?? TokenAliasModel.local(tokenName);
  }

  List<String> _getRemainingTokens(List<String> tokenNames, List<TokenAliasModel> tokenAliasModelList) {
    List<String> fetchedTokens = tokenAliasModelList.map((TokenAliasModel tokenAliasModel) => tokenAliasModel.defaultTokenDenominationModel.name).toList();
    return tokenNames.where((String tokenName) => fetchedTokens.contains(tokenName) == false).toList();
  }
}
