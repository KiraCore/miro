import 'package:decimal/decimal.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';

class TokenAmount {
  late TokenDenomination _tokenDenomination;

  Decimal amount;

  TokenAmount({
    required TokenDenomination tokenDenomination,
    Decimal? amount,
  })  : _tokenDenomination = tokenDenomination,
        amount = amount ?? Decimal.zero;

  TokenDenomination get tokenDenomination => _tokenDenomination;

  set tokenDenomination(TokenDenomination tokenDenomination) {
    if (tokenDenomination == _tokenDenomination) {
      return;
    }
    amount = calculateAmountAsDenomination(tokenDenomination);
    _tokenDenomination = tokenDenomination;
  }

  Decimal calculateAmountAsDenomination(TokenDenomination tokenDenomination) {
    int decimalsDifference = _tokenDenomination.decimals - tokenDenomination.decimals;
    Decimal calculatedAmount = amount.shift(decimalsDifference);
    return calculatedAmount;
  }

  int compareTo(TokenAmount other, TokenDenomination tokenDenomination) {
    Decimal currentAmount = calculateAmountAsDenomination(tokenDenomination);
    Decimal otherAmount = other.calculateAmountAsDenomination(tokenDenomination);
    return otherAmount.compareTo(currentAmount);
  }

  @override
  String toString() {
    return '${amount} ${_tokenDenomination.name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAmount &&
          runtimeType == other.runtimeType &&
          _tokenDenomination == other._tokenDenomination &&
          amount == other.amount;

  @override
  int get hashCode => _tokenDenomination.hashCode ^ amount.hashCode;
}
