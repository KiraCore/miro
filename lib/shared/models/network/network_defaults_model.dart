import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class NetworkDefaultsModel extends Equatable {
  final String defaultAddressPrefix;
  final TokenAliasModel defaultTokenAliasModel;

  const NetworkDefaultsModel({
    required this.defaultAddressPrefix,
    required this.defaultTokenAliasModel,
  });

  factory NetworkDefaultsModel.fromDto(QueryKiraTokensAliasesResp queryKiraTokensAliasesResp) {
    return NetworkDefaultsModel(
      defaultAddressPrefix: queryKiraTokensAliasesResp.bech32Prefix,
      defaultTokenAliasModel: TokenAliasModel.local(queryKiraTokensAliasesResp.defaultDenom),
    );
  }

  @override
  List<Object?> get props => <Object>[defaultAddressPrefix, defaultTokenAliasModel];
}
