import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class TokenDefaultDenomModel extends Equatable {
  final String publicAddressPrefix;
  final TokenAliasModel defaultTokenAliasModel;

  const TokenDefaultDenomModel({
    required this.publicAddressPrefix,
    required this.defaultTokenAliasModel,
  });

  factory TokenDefaultDenomModel.fromDto(QueryKiraTokensAliasesResp queryKiraTokensAliasesResp) {
    return TokenDefaultDenomModel(
      publicAddressPrefix: queryKiraTokensAliasesResp.bech32Prefix,
      defaultTokenAliasModel: TokenAliasModel.local(queryKiraTokensAliasesResp.defaultDenom),
    );
  }

  @override
  List<Object?> get props => <Object>[publicAddressPrefix, defaultTokenAliasModel];
}
