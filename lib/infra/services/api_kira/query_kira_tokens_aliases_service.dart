import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';

abstract class _QueryKiraTokensAliasesService {
  Future<QueryKiraTokensAliasesResp> getTokenAliases();

  void ignore();
}

class QueryKiraTokensAliasesService implements _QueryKiraTokensAliasesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryKiraTokensAliasesResp> getTokenAliases({Uri? customNetworkUri}) async {
    Uri networkUri = customNetworkUri ?? globalLocator<NetworkModuleBloc>().state.networkUri;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(networkUri);
    return QueryKiraTokensAliasesResp.fromJsonList(response.data as List<dynamic>);
  }

  @override
  // TODO(dominik): To remove
  void ignore() {}
}
