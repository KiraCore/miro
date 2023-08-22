import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';

class TokenStorageState extends Equatable {
  final String? defaultAddressPrefix;
  final TokenAliasModel? defaultTokenAliasModel;
  final Map<String, TokenAliasModel>? tokenAliasMap;

  const TokenStorageState({
    this.defaultAddressPrefix,
    this.defaultTokenAliasModel,
    this.tokenAliasMap,
  });

  @override
  List<Object?> get props => <Object?>[defaultAddressPrefix, defaultTokenAliasModel];
}
