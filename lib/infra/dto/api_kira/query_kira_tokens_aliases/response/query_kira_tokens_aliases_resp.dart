import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';

class QueryKiraTokensAliasesResp extends Equatable {
  final List<TokenAlias> tokenAliases;

  const QueryKiraTokensAliasesResp({
    required this.tokenAliases,
  });

  factory QueryKiraTokensAliasesResp.fromJsonList(List<dynamic> jsonList) {
    return QueryKiraTokensAliasesResp(
      tokenAliases: jsonList
          .map(
            (dynamic e) => TokenAlias.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[tokenAliases.hashCode];

  @override
  String toString() {
    return 'QueryKiraTokensAliasesResp{tokenAliases: $tokenAliases}';
  }
}
