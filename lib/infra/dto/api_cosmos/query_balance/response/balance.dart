class Balance {
  final String amount;
  final String denom;

  Balance({
    required this.amount,
    required this.denom,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
    amount: json['amount'] as String,
    denom: json['denom'] as String,
  );

  @override
  String toString() {
    return 'Balance{amount: $amount, denom: $denom}';
  }
}