import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';

class TokenDenomination extends Equatable {
  final String symbol;
  final int decimals;

  const TokenDenomination({
    required this.symbol,
    required this.decimals,
  });

  factory TokenDenomination.fromTokenAlias(TokenAlias tokenAlias) {
    return TokenDenomination(
      symbol: tokenAlias.lowestDenomination,
      decimals: 0,
    );
  }

  @override
  List<Object> get props => <Object>[symbol, decimals];
}
