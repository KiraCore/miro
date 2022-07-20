import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/tokens/token_denomination.dart';

class TokenSectionController extends ChangeNotifier {
  final ValueNotifier<TokenAmount?> tokenAmountNotifier = ValueNotifier<TokenAmount?>(null);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final TextEditingController amountTextEditingController = TextEditingController();

  void setAmount(Decimal amount) {
    if (tokenAmountNotifier.value != null) {
      tokenAmountNotifier.value!.setAmount(amount);
    }
    notifyListeners();
  }

  void setTokenAliasModel(TokenAliasModel tokenAliasModel) {
    amountTextEditingController.clear();
    tokenAmountNotifier.value = TokenAmount(
      lowestDenominationAmount: Decimal.zero,
      tokenAliasModel: tokenAliasModel,
    );
    notifyListeners();
  }

  void setTokenDenomination(TokenDenomination tokenDenomination) {
    if (tokenAmountNotifier.value != null) {
      String amountText = tokenAmountNotifier.value!.getAsDenomination(tokenDenomination).toString();
      amountTextEditingController.text = amountText;
    }
    notifyListeners();
  }

  void setError(String? error) {
    errorNotifier.value = error;
  }
}
