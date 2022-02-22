import 'package:equatable/equatable.dart';

class TokenRate extends Equatable {
  final String denom;
  final bool feePayments;
  final String rate;

  const TokenRate({
    required this.denom,
    required this.feePayments,
    required this.rate,
  });

  factory TokenRate.fromJson(Map<String, dynamic> json) {
    return TokenRate(
      denom: json['denom'] as String,
      feePayments: json['feePayments'] as bool? ?? false,
      rate: json['rate'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[denom.hashCode, feePayments.hashCode, rate.hashCode];

  @override
  String toString() {
    return 'TokenRate{denom: $denom, feePayments: $feePayments, rate: $rate}';
  }
}
