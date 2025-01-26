import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

abstract class _IQueryKiraTokensAliasesService {
  List<TokenAliasModel> getTokenAliasModels();

  TokenDefaultDenomModel getTokenDefaultDenomModel();
}

class QueryKiraTokensAliasesService implements _IQueryKiraTokensAliasesService {
  // NOTE(Mykyta): We decided to hardcode aliases instead of using the Remote Config for that.
  // The remote place is pretty much useless in our case.CDN / other BE service would be too difficult to setup just for this task.
  // It can be hardcoded instead for now, and business will not be affected.
  // Also, dynamic denomination is postponed for an unknown period of time.
  static const QueryKiraTokensAliasesResp _defaultAliases = QueryKiraTokensAliasesResp(
    tokenAliases: <TokenAlias>[
      TokenAlias(
        decimals: 6,
        denoms: <String>['ukex'],
        name: 'ukex',
        symbol: 'ukex',
        // TODO(Mykyta): make nullable
        icon: '',
        // TODO(Mykyta): make int, and get from api, but in another model
        amount: '0',
      ),
    ],
    defaultDenom: 'ukex',
    bech32Prefix: 'kira',
  );

  @override
  List<TokenAliasModel> getTokenAliasModels() {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _defaultAliases;
    return queryKiraTokensAliasesResp.tokenAliases.map(TokenAliasModel.fromDto).toList();
  }

  @override
  TokenDefaultDenomModel getTokenDefaultDenomModel() {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _defaultAliases;
    return TokenDefaultDenomModel(
      // TODO(Mykyta): useless var ?? valuesFromNetworkExistBool
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: queryKiraTokensAliasesResp.bech32Prefix,
      defaultTokenAliasModel: _getAliasByTokenName(queryKiraTokensAliasesResp.defaultDenom),
    );
  }

  TokenAliasModel? _getAliasByTokenName(String tokenName) {
    QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = _defaultAliases;
    return TokenAliasModel.fromDto(
      queryKiraTokensAliasesResp.tokenAliases.firstWhere(
        (TokenAlias alias) => alias.name == tokenName,
        orElse: () => queryKiraTokensAliasesResp.tokenAliases.first,
      ),
    );
  }
}
