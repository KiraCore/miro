import 'package:equatable/equatable.dart';

class TokenAlias extends Equatable {
  final int decimals;
  final List<String> denoms;
  final String name;
  final String symbol;
  final String icon;
  // TODO(Mykyta): remove amount from this static model
  @Deprecated('This field is not representative here. TokenAlias is static. amount should be observed elsewhere')
  final String amount;

  const TokenAlias({
    required this.decimals,
    required this.denoms,
    required this.name,
    required this.symbol,
    required this.icon,
    @Deprecated('This field is not representative here. TokenAlias is static. amount should be observed elsewhere')
    required this.amount,
  });

  factory TokenAlias.fromJson(Map<String, dynamic> json) {
    return TokenAlias(
      decimals: json['decimals'] as int,
      denoms: (json['denoms'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      icon: json['icon'] as String,
      amount: json['amount'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'decimals': decimals,
        'denoms': denoms,
        'name': name,
        'symbol': symbol,
        'icon': icon,
        'amount': amount,
      };

  @override
  List<Object?> get props => <Object>[decimals, denoms, name, symbol, icon, amount];
}
