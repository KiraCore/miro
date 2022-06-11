import 'package:equatable/equatable.dart';

// TODO(dominik): Unify response classes with the other.
// For example the same [Coin] class exists in Broadcast
class Coin extends Equatable {
  final String denom;
  final String amount;

  const Coin({
    required this.denom,
    required this.amount,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      denom: json['denom'] as String,
      amount: json['amount'] as String,
    );
  }

  @override
  String toString() {
    return 'Coin{denom: $denom, amount: $amount}';
  }

  @override
  List<Object?> get props => <Object?>[
        denom,
        amount,
      ];
}
