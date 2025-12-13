import 'package:equatable/equatable.dart';

class TokenAlias extends Equatable {
  final int decimals;
  final List<String> denoms;
  final String name;
  final String symbol;
  final String icon;
  final String amount;

  const TokenAlias({
    required this.decimals,
    required this.denoms,
    required this.name,
    required this.symbol,
    required this.icon,
    required this.amount,
  });

  factory TokenAlias.fromJson(Map<String, dynamic> json) {
    return TokenAlias(
      decimals: json['decimals'] as int,
      denoms: <String>[json['denom'] as String],
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      icon: json['icon'] as String,
      amount: json['amount'] as String? ?? '0',
    );
  }

  @override
  List<Object?> get props => <Object>[decimals, denoms, name, symbol, icon, amount];
}
