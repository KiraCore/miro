import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';

class QueryKiraTokensAliasesResp extends Equatable {
  final List<TokenAlias> tokenAliases;
  final String defaultDenom;
  final String bech32Prefix;

  const QueryKiraTokensAliasesResp({
    required this.tokenAliases,
    required this.defaultDenom,
    required this.bech32Prefix,
  });

  factory QueryKiraTokensAliasesResp.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['token_aliases_data'] as List<dynamic>;
    return QueryKiraTokensAliasesResp(
      tokenAliases: jsonList.map((dynamic e) => TokenAlias.fromJson(e as Map<String, dynamic>)).toList(),
      defaultDenom: json['default_denom'] as String,
      bech32Prefix: json['bech32_prefix'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[tokenAliases.hashCode, defaultDenom, bech32Prefix];
}
