import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

/// Defines a token with a denomination and an amount.
class Coin extends Equatable {
  final String amount;
  final String denom;

  const Coin({
    required this.amount,
    required this.denom,
  });

  factory Coin.fromTokenAmountModel(TokenAmountModel tokenAmountModel) {
    return Coin(
      denom: tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
      amount: tokenAmountModel.getAmountInDefaultDenomination().toString(),
    );
  }

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      amount: json['amount'] as String,
      denom: json['denom'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': amount,
      'denom': denom,
    };
  }

  @override
  List<Object?> get props => <Object?>[amount, denom];
}
