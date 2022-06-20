/// Defines a token with a denomination and an amount.
class Coin {
  final BigInt amount;
  final String denom;

  const Coin({
    required this.amount,
    required this.denom,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': amount.toString(),
      'denom': denom,
    };
  }
}
