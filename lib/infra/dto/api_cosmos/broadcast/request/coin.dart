import 'package:miro/shared/models/tokens/token_amount_model.dart';

/// Defines a token with a denomination and an amount.
class Coin {
  final String amount;
  final String denom;

  const Coin({
    required this.amount,
    required this.denom,
  });

  factory Coin.fromTokenAmountModel(TokenAmountModel tokenAmountModel) {
    return Coin(
      denom: tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name,
      amount: tokenAmountModel.getAmountInLowestDenomination().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'amount': amount,
      'denom': denom,
    };
  }
}
