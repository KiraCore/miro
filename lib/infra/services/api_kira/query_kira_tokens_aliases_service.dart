import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

abstract class _IQueryKiraTokensAliasesService {
  Future<List<TokenAliasModel>> getTokenAliasModels();
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<List<TokenAliasModel>> getTokenAliasModels() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(networkUri);
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJsonList(response.data as List<dynamic>);
    return queryKiraTokensAliasesResp.tokenAliases.map((TokenAlias tokenAlias) {
      return TokenAliasModel.fromDto(tokenAlias);
    }).toList();
  }
}
