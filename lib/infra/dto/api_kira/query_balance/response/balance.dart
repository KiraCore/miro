import 'package:equatable/equatable.dart';

class Balance extends Equatable {
  final String amount;
  final String denom;

  const Balance({
    required this.amount,
    required this.denom,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        amount: json['amount'] as String,
        denom: json['denom'] as String,
      );

  @override
  List<Object?> get props => <Object>[amount, denom];
}
