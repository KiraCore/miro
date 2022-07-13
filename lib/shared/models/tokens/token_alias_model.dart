import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';

class TokenAliasModel {
  final String name;
  final TokenDenomination lowestTokenDenomination;
  final TokenDenomination defaultTokenDenomination;
  final String? icon;

  TokenAliasModel({
    required this.name,
    required this.lowestTokenDenomination,
    TokenDenomination? defaultTokenDenomination,
    this.icon,
  }) : defaultTokenDenomination = defaultTokenDenomination ?? lowestTokenDenomination;

  factory TokenAliasModel.local(String name) {
    return TokenAliasModel(
      name: name,
      lowestTokenDenomination: TokenDenomination(name: name, decimals: 0),
    );
  }

  factory TokenAliasModel.fromTokenAlias(TokenAlias tokenAlias) {
    TokenDenomination defaultTokenDenomination = TokenDenomination(
      name: tokenAlias.symbol,
      decimals: tokenAlias.decimals,
    );
    TokenDenomination lowestTokenDenomination = tokenAlias.denoms.isNotEmpty
        ? TokenDenomination(name: tokenAlias.denoms.first, decimals: 0)
        : defaultTokenDenomination;

    return TokenAliasModel(
      name: tokenAlias.name,
      icon: tokenAlias.icon,
      defaultTokenDenomination: defaultTokenDenomination,
      lowestTokenDenomination: lowestTokenDenomination,
    );
  }

  List<TokenDenomination> get tokenDenominations {
    Set<TokenDenomination> availableDenominations = <TokenDenomination>{
      lowestTokenDenomination,
      defaultTokenDenomination,
    };
    return availableDenominations.toList();
  }
}
