import 'package:equatable/equatable.dart';

class Amount extends Equatable {
  final String denom;
  final String amount;

  const Amount({
    required this.denom,
    required this.amount,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      denom: json['denom'] as String,
      amount: json['amount'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[denom, amount];

  @override
  String toString() {
    return 'Amount{denom: $denom, amount: $amount}';
  }
}
