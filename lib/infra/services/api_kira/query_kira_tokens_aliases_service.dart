import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/request/query_kira_tokens_aliases_req.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryKiraTokensAliasesService {
  Future<List<TokenAliasModel>> getTokenAliasModels();

  Future<TokenDefaultDenomModel> getTokenDefaultDenomModel(Uri networkUri);
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<TokenAliasModel>> getTokenAliasModels() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(ApiRequestModel<QueryKiraTokensAliasesReq>(
      networkUri: networkUri,
      requestData: const QueryKiraTokensAliasesReq(),
    ));

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJson(response.data as Map<String, dynamic>);
      return queryKiraTokensAliasesResp.tokenAliases.map(TokenAliasModel.fromDto).toList();
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensAliasesService: Cannot parse getTokenAliasModels() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<TokenDefaultDenomModel> getTokenDefaultDenomModel(Uri networkUri, {bool forceRequestBool = false}) async {
    TokenDefaultDenomModel initialTokenDefaultDenomModel = await _getTokenDefaultDenom(networkUri);
    try {
      TokenAliasModel defaultTokenAliasModel = await _getAliasByTokenName(
        initialTokenDefaultDenomModel.defaultTokenAliasModel.name,
        networkUri: networkUri,
        forceRequestBool: forceRequestBool,
      );
      return TokenDefaultDenomModel(
        bech32AddressPrefix: initialTokenDefaultDenomModel.bech32AddressPrefix,
        defaultTokenAliasModel: defaultTokenAliasModel,
      );
    } catch (e) {
      return initialTokenDefaultDenomModel;
    }
  }

  Future<TokenAliasModel> _getAliasByTokenName(String tokenName, {Uri? networkUri, bool forceRequestBool = false}) async {
    networkUri ??= globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(ApiRequestModel<QueryKiraTokensAliasesReq>(
      networkUri: networkUri,
      requestData: QueryKiraTokensAliasesReq(tokens: <String>[tokenName]),
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJson(response.data as Map<String, dynamic>);
      return TokenAliasModel.fromDto(queryKiraTokensAliasesResp.tokenAliases.first);
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensAliasesService: Cannot parse getAliasByTokenName() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  Future<TokenDefaultDenomModel> _getTokenDefaultDenom(Uri networkUri) async {
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(ApiRequestModel<QueryKiraTokensAliasesReq>(
      networkUri: networkUri,
      requestData: const QueryKiraTokensAliasesReq(offset: 0, limit: 0),
    ));

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJson(response.data as Map<String, dynamic>);
      return TokenDefaultDenomModel.fromDto(queryKiraTokensAliasesResp);
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensAliasesService: Cannot parse getTokenDefaultDenom() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
