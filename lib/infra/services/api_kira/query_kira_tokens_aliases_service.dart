import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryKiraTokensAliasesService {
  Future<List<TokenAliasModel>> getTokenAliasModels();
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<List<TokenAliasModel>> getTokenAliasModels() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensAliases<dynamic>(networkUri);

    try {
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = QueryKiraTokensAliasesResp.fromJsonList(response.data as List<dynamic>);
      return queryKiraTokensAliasesResp.tokenAliases.map(TokenAliasModel.fromDto).toList();
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensAliasesService: Cannot parse getTokenAliasModels() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
