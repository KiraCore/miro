import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenAmountModel {
  final TokenAliasModel tokenAliasModel;
  late Decimal _defaultDenominationAmount;

  TokenAmountModel({
    required Decimal defaultDenominationAmount,
    required this.tokenAliasModel,
  }) {
    if (defaultDenominationAmount < Decimal.zero) {
      _defaultDenominationAmount = Decimal.fromInt(-1);
    } else {
      _defaultDenominationAmount = defaultDenominationAmount;
    }
  }

  TokenAmountModel.zero({required this.tokenAliasModel}) : _defaultDenominationAmount = Decimal.zero;

  factory TokenAmountModel.fromString(String value) {
    RegExp regExpPattern = RegExp(r'(\d+)([a-zA-Z0-9/]+)');
    RegExpMatch regExpMatch = regExpPattern.firstMatch(value)!;

    Decimal amount = Decimal.parse(regExpMatch.group(1)!);
    String denom = regExpMatch.group(2)!;

    return TokenAmountModel(
      defaultDenominationAmount: amount,
      tokenAliasModel: TokenAliasModel.local(denom),
    );
  }

  TokenAmountModel copyWith({
    TokenAliasModel? tokenAliasModel,
  }) {
    return TokenAmountModel(
      defaultDenominationAmount: _defaultDenominationAmount,
      tokenAliasModel: tokenAliasModel ?? this.tokenAliasModel,
    );
  }

  TokenAmountModel copy() {
    return TokenAmountModel(
      defaultDenominationAmount: _defaultDenominationAmount,
      tokenAliasModel: tokenAliasModel,
    );
  }

  int compareTo(TokenAmountModel tokenAmountModel) {
    return tokenAmountModel._defaultDenominationAmount.compareTo(_defaultDenominationAmount);
  }

  Decimal getAmountInDefaultDenomination() {
    return _defaultDenominationAmount;
  }

  Decimal getAmountInNetworkDenomination() {
    return getAmountInDenomination(tokenAliasModel.networkTokenDenominationModel);
  }

  Decimal getAmountInDenomination(TokenDenominationModel tokenDenominationModel) {
    bool defaultTokenDenominationBool = tokenDenominationModel == tokenAliasModel.defaultTokenDenominationModel;
    if (defaultTokenDenominationBool) {
      return _defaultDenominationAmount;
    }
    int decimalsDifference = tokenAliasModel.defaultTokenDenominationModel.decimals - tokenDenominationModel.decimals;
    Decimal calculatedAmount = _defaultDenominationAmount.shift(decimalsDifference);
    return calculatedAmount;
  }

  void setAmount(Decimal amount, {TokenDenominationModel? tokenDenominationModel}) {
    if (amount < Decimal.zero) {
      throw ArgumentError('Amount must be greater than zero');
    }
    TokenDenominationModel defaultTokenDenomination = tokenAliasModel.defaultTokenDenominationModel;

    bool defaultTokenDenominationBool = tokenDenominationModel == null || tokenDenominationModel == defaultTokenDenomination;
    if (defaultTokenDenominationBool) {
      _defaultDenominationAmount = amount;
    } else {
      int decimalsDifference = tokenDenominationModel.decimals - defaultTokenDenomination.decimals;
      _defaultDenominationAmount = amount.shift(decimalsDifference);
    }
  }

  TokenAmountModel operator +(TokenAmountModel tokenAmountModel) {
    if (tokenAmountModel.tokenAliasModel != tokenAliasModel) {
      return this;
    }
    Decimal newAmount = _defaultDenominationAmount + tokenAmountModel._defaultDenominationAmount;
    return TokenAmountModel(
      defaultDenominationAmount: newAmount,
      tokenAliasModel: tokenAliasModel,
    );
  }

  TokenAmountModel operator -(TokenAmountModel tokenAmountModel) {
    if (tokenAmountModel.tokenAliasModel != tokenAliasModel) {
      return this;
    }
    Decimal newAmount = _defaultDenominationAmount - tokenAmountModel._defaultDenominationAmount;
    return TokenAmountModel(
      defaultDenominationAmount: newAmount < Decimal.zero ? Decimal.zero : newAmount,
      tokenAliasModel: tokenAliasModel,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAmountModel &&
          runtimeType == other.runtimeType &&
          _defaultDenominationAmount == other._defaultDenominationAmount &&
          tokenAliasModel == other.tokenAliasModel;

  @override
  int get hashCode => _defaultDenominationAmount.hashCode ^ tokenAliasModel.hashCode;

  @override
  String toString() {
    return '${_defaultDenominationAmount} ${tokenAliasModel.defaultTokenDenominationModel.name}';
  }
}
