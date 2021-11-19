class DepositsTx {
  final String address;
  final String type;
  final String denom;
  final int amount;

  DepositsTx({
    required this.address,
    required this.type,
    required this.denom,
    required this.amount,
  });

  factory DepositsTx.fromJson(Map<String, dynamic> json) => DepositsTx(
    address: json['address'] as String,
    type: json['type'] as String,
    denom: json['denom'] as String,
    amount: json['amount'] as int,
  );

  @override
  String toString() {
    return 'DepositsTx{address: $address, type: $type, denom: $denom, amount: $amount}';
  }
}
