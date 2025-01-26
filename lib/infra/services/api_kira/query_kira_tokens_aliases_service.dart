import 'package:miro/config/locator.dart';
import 'package:miro/config/remote_config.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

abstract class _IQueryKiraTokensAliasesService {
  List<TokenAliasModel> getTokenAliasModels();

  TokenDefaultDenomModel getTokenDefaultDenomModel();
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  final RemoteConfig _remoteConfig = globalLocator<RemoteConfig>();

  @override
  List<TokenAliasModel> getTokenAliasModels() {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _remoteConfig.getAliases();
    return queryKiraTokensAliasesResp.tokenAliases.map(TokenAliasModel.fromDto).toList();
  }

  @override
  TokenDefaultDenomModel getTokenDefaultDenomModel() {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _remoteConfig.getAliases();
    return TokenDefaultDenomModel(
      // TODO(Mykyta): useless var ?? valuesFromNetworkExistBool
      valuesFromNetworkExistBool: queryKiraTokensAliasesResp.tokenAliases.isNotEmpty,
      bech32AddressPrefix:
          queryKiraTokensAliasesResp.bech32Prefix.isEmpty ? null : queryKiraTokensAliasesResp.bech32Prefix,
      defaultTokenAliasModel: queryKiraTokensAliasesResp.tokenAliases.isEmpty
          ? null
          : _getAliasByTokenName(queryKiraTokensAliasesResp.defaultDenom),
    );
  }

  TokenAliasModel? _getAliasByTokenName(String tokenName) {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _remoteConfig.getAliases();
    return TokenAliasModel.fromDto(
      queryKiraTokensAliasesResp.tokenAliases.firstWhere(
        (TokenAlias alias) => alias.name == tokenName,
        orElse: () => queryKiraTokensAliasesResp.tokenAliases.first,
      ),
    );
  }
}
