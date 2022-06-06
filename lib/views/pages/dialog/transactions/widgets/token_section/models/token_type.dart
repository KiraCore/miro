import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';

class TokenType {
  final String name;
  final TokenDenomination lowestTokenDenomination;
  final TokenDenomination defaultTokenDenomination;
  final String icon;

  TokenType({
    required this.name,
    required this.lowestTokenDenomination,
    TokenDenomination? defaultTokenDenomination,
    this.icon = '',
  }) : defaultTokenDenomination = defaultTokenDenomination ?? lowestTokenDenomination;

  factory TokenType.fromTokenAlias(TokenAlias tokenAlias) {
    TokenDenomination defaultTokenDenomination = TokenDenomination(
      name: tokenAlias.symbol,
      decimals: tokenAlias.decimals,
    );
    TokenDenomination lowestTokenDenomination = tokenAlias.denoms.isNotEmpty
        ? TokenDenomination(name: tokenAlias.denoms.first, decimals: 0)
        : defaultTokenDenomination;

    return TokenType(
      name: tokenAlias.symbol,
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
