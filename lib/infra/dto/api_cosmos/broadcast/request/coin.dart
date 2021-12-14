/// Defines a token with a denomination and an amount.
class Coin {
  final BigInt value;
  final String denom;

  const Coin({
    required this.value,
    required this.denom,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': value.toString(),
      'denom': denom,
    };
  }
}
