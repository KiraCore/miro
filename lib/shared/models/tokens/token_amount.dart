import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';

class TokenAmount {
  final TokenAliasModel tokenAliasModel;
  late Decimal _amount;

  TokenAmount({
    required Decimal lowestDenominationAmount,
    required this.tokenAliasModel,
  }) : _amount = lowestDenominationAmount;

  void setAmount(Decimal amount, {TokenDenomination? tokenDenomination}) {
    _amount = _calcAmountAsDenomination(amount, tokenDenomination ?? tokenAliasModel.lowestTokenDenomination);
  }

  Decimal getAsLowestDenomination() {
    return _amount;
  }

  Decimal getAsDefaultDenomination() {
    return getAsDenomination(tokenAliasModel.defaultTokenDenomination);
  }

  Decimal getAsDenomination(TokenDenomination tokenDenomination) {
    return _calcAmountAsDenomination(_amount, tokenDenomination);
  }

  int compareTo(TokenAmount other) {
    return other._amount.compareTo(_amount);
  }

  Decimal _calcAmountAsDenomination(Decimal amount, TokenDenomination tokenDenomination) {
    if (tokenDenomination == tokenAliasModel.lowestTokenDenomination) {
      return amount;
    }
    int decimalsDifference = tokenAliasModel.lowestTokenDenomination.decimals - tokenDenomination.decimals;
    Decimal calculatedAmount = amount.shift(decimalsDifference);
    return calculatedAmount;
  }

  @override
  String toString() {
    return '${_amount} ${tokenAliasModel.lowestTokenDenomination.name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAmount &&
          runtimeType == other.runtimeType &&
          _amount == other._amount &&
          tokenAliasModel == other.tokenAliasModel;

  @override
  int get hashCode => _amount.hashCode ^ tokenAliasModel.hashCode;
}
