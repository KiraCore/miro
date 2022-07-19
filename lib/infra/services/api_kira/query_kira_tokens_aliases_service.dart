import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IQueryKiraTokensAliasesService {
  /// Throws [DioError]
  Future<QueryKiraTokensAliasesResp> getTokenAliases({Uri? optionalNetworkUri});
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryKiraTokensAliasesResp> getTokenAliases({Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(networkUri);
    return QueryKiraTokensAliasesResp.fromJsonList(response.data as List<dynamic>);
  }
}
