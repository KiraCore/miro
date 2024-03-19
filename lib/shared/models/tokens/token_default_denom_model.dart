import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class TokenDefaultDenomModel with EquatableMixin {
  final bool valuesFromNetworkExistBool;
  final String? bech32AddressPrefix;
  final TokenAliasModel? defaultTokenAliasModel;

  TokenDefaultDenomModel({
    required this.valuesFromNetworkExistBool,
    required this.bech32AddressPrefix,
    required this.defaultTokenAliasModel,
  });

  factory TokenDefaultDenomModel.fromDto(QueryKiraTokensAliasesResp queryKiraTokensAliasesResp) {
    return TokenDefaultDenomModel(
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: queryKiraTokensAliasesResp.bech32Prefix,
      defaultTokenAliasModel: TokenAliasModel.local(queryKiraTokensAliasesResp.defaultDenom),
    );
  }

  factory TokenDefaultDenomModel.empty() {
    return TokenDefaultDenomModel(
      valuesFromNetworkExistBool: false,
      bech32AddressPrefix: null,
      defaultTokenAliasModel: null,
    );
  }

  TokenDefaultDenomModel copyWith(TokenDefaultDenomModel tokenDefaultDenomModel) {
    return TokenDefaultDenomModel(
      valuesFromNetworkExistBool: tokenDefaultDenomModel.valuesFromNetworkExistBool,
      bech32AddressPrefix: tokenDefaultDenomModel.bech32AddressPrefix,
      defaultTokenAliasModel: tokenDefaultDenomModel.defaultTokenAliasModel,
    );
  }

  @override
  List<Object?> get props => <Object?>[valuesFromNetworkExistBool, bech32AddressPrefix, defaultTokenAliasModel];
}
