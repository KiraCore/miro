import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenAliasModel {
  final String name;
  final TokenDenominationModel lowestTokenDenominationModel;
  final TokenDenominationModel defaultTokenDenominationModel;
  final String? icon;

  TokenAliasModel({
    required this.name,
    required this.lowestTokenDenominationModel,
    TokenDenominationModel? defaultTokenDenominationModel,
    this.icon,
  }) : defaultTokenDenominationModel = defaultTokenDenominationModel ?? lowestTokenDenominationModel;

  factory TokenAliasModel.local(String name) {
    return TokenAliasModel(
      name: name,
      lowestTokenDenominationModel: TokenDenominationModel(name: name, decimals: 0),
    );
  }

  factory TokenAliasModel.fromDto(TokenAlias tokenAlias) {
    TokenDenominationModel defaultTokenDenominationModel = TokenDenominationModel(
      name: tokenAlias.symbol,
      decimals: tokenAlias.decimals,
    );
    TokenDenominationModel lowestTokenDenominationModel =
        tokenAlias.denoms.isNotEmpty ? TokenDenominationModel(name: tokenAlias.denoms.first, decimals: 0) : defaultTokenDenominationModel;

    return TokenAliasModel(
      name: tokenAlias.name,
      icon: tokenAlias.icon,
      defaultTokenDenominationModel: defaultTokenDenominationModel,
      lowestTokenDenominationModel: lowestTokenDenominationModel,
    );
  }

  List<TokenDenominationModel> get tokenDenominations {
    Set<TokenDenominationModel> availableTokenDenominationModelSet = <TokenDenominationModel>{
      lowestTokenDenominationModel,
      defaultTokenDenominationModel,
    };
    return availableTokenDenominationModelSet.toList();
  }
}
