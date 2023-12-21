import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenAliasModel extends Equatable {
  final String name;
  final TokenDenominationModel defaultTokenDenominationModel;
  final TokenDenominationModel networkTokenDenominationModel;
  final String? icon;

  const TokenAliasModel({
    required this.name,
    required this.defaultTokenDenominationModel,
    TokenDenominationModel? networkTokenDenominationModel,
    this.icon,
  }) : networkTokenDenominationModel = networkTokenDenominationModel ?? defaultTokenDenominationModel;

  factory TokenAliasModel.local(String name) {
    return TokenAliasModel(
      name: name,
      defaultTokenDenominationModel: TokenDenominationModel(name: name, decimals: 0),
    );
  }

  factory TokenAliasModel.fromDto(TokenAlias tokenAlias) {
    TokenDenominationModel networkTokenDenominationModel = TokenDenominationModel(
      name: tokenAlias.symbol,
      decimals: tokenAlias.decimals,
    );
    TokenDenominationModel defaultTokenDenominationModel =
        tokenAlias.denoms.isNotEmpty ? TokenDenominationModel(name: tokenAlias.denoms.first, decimals: 0) : networkTokenDenominationModel;

    return TokenAliasModel(
      name: tokenAlias.name,
      icon: tokenAlias.icon,
      networkTokenDenominationModel: networkTokenDenominationModel,
      defaultTokenDenominationModel: defaultTokenDenominationModel,
    );
  }

  List<TokenDenominationModel> get tokenDenominations {
    Set<TokenDenominationModel> availableTokenDenominationModelSet = <TokenDenominationModel>{
      defaultTokenDenominationModel,
      networkTokenDenominationModel,
    };
    return availableTokenDenominationModelSet.toList();
  }

  @override
  List<Object?> get props => <Object>[defaultTokenDenominationModel];
}
