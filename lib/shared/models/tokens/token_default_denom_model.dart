import 'package:equatable/equatable.dart';
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

  factory TokenDefaultDenomModel.empty() {
    return TokenDefaultDenomModel(
      valuesFromNetworkExistBool: false,
      bech32AddressPrefix: null,
      defaultTokenAliasModel: null,
    );
  }

  @override
  List<Object?> get props => <Object?>[valuesFromNetworkExistBool, bech32AddressPrefix, defaultTokenAliasModel];
}
