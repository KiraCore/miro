import 'package:equatable/equatable.dart';

class TokenRate extends Equatable {
  final String denom;
  final bool feePayments;
  final String feeRate;
  final String stakeCap;
  final String stakeMin;
  final bool stakeToken;

  const TokenRate({
    required this.denom,
    required this.feePayments,
    required this.feeRate,
    required this.stakeCap,
    required this.stakeMin,
    required this.stakeToken,
  });

  factory TokenRate.fromJson(Map<String, dynamic> json) {
    return TokenRate(
      denom: json['denom'] as String,
      feePayments: json['fee_payments'] as bool,
      feeRate: json['fee_rate'] as String,
      stakeCap: json['stake_cap'] as String,
      stakeMin: json['stake_min'] as String,
      stakeToken: json['stake_token'] as bool,
    );
  }

  @override
  List<Object?> get props => <Object>[denom, feePayments, feeRate, stakeCap, stakeMin, stakeToken];
}
