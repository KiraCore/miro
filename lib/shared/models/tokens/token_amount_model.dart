import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenAmountModel {
  final TokenAliasModel tokenAliasModel;
  late Decimal _lowestDenominationAmount;

  TokenAmountModel({
    required Decimal lowestDenominationAmount,
    required this.tokenAliasModel,
  }) {
    if (lowestDenominationAmount < Decimal.zero) {
      _lowestDenominationAmount = Decimal.fromInt(-1);
    } else {
      _lowestDenominationAmount = lowestDenominationAmount;
    }
  }

  int compareTo(TokenAmountModel tokenAmountModel) {
    return tokenAmountModel._lowestDenominationAmount.compareTo(_lowestDenominationAmount);
  }

  Decimal getAmountInLowestDenomination() {
    return _lowestDenominationAmount;
  }

  Decimal getAmountInDefaultDenomination() {
    return getAmountInDenomination(tokenAliasModel.defaultTokenDenominationModel);
  }

  Decimal getAmountInDenomination(TokenDenominationModel tokenDenominationModel) {
    bool isLowestTokenDenomination = tokenDenominationModel == tokenAliasModel.lowestTokenDenominationModel;
    if (isLowestTokenDenomination) {
      return _lowestDenominationAmount;
    }
    int decimalsDifference = tokenAliasModel.lowestTokenDenominationModel.decimals - tokenDenominationModel.decimals;
    Decimal calculatedAmount = _lowestDenominationAmount.shift(decimalsDifference);
    return calculatedAmount;
  }

  void setAmount(Decimal amount, {TokenDenominationModel? tokenDenominationModel}) {
    if (amount < Decimal.zero) {
      throw ArgumentError('Amount must be greater than zero');
    }
    TokenDenominationModel lowestTokenDenomination = tokenAliasModel.lowestTokenDenominationModel;

    bool isLowestTokenDenomination = tokenDenominationModel == null || tokenDenominationModel == lowestTokenDenomination;
    if (isLowestTokenDenomination) {
      _lowestDenominationAmount = amount;
    } else {
      int decimalsDifference = tokenDenominationModel.decimals - lowestTokenDenomination.decimals;
      _lowestDenominationAmount = amount.shift(decimalsDifference);
    }
  }

  @override
  String toString() {
    return '${_lowestDenominationAmount} ${tokenAliasModel.lowestTokenDenominationModel.name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAmountModel &&
          runtimeType == other.runtimeType &&
          _lowestDenominationAmount == other._lowestDenominationAmount &&
          tokenAliasModel == other.tokenAliasModel;

  @override
  int get hashCode => _lowestDenominationAmount.hashCode ^ tokenAliasModel.hashCode;
}
