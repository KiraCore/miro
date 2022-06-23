import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_amount.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';

class TokenSectionController extends ChangeNotifier {
  final List<Balance> availableBalances;
  final WalletAddress? walletAddress;
  final ValueNotifier<String?> errorMessageNotifier = ValueNotifier<String?>(null);
  final TextEditingController amountValueTextController = TextEditingController();

  TokenType? selectedTokenType;
  TokenAmount? sendTokenAmount;
  TokenAmount? availableTokenAmount;

  TokenSectionController({
    List<Balance>? availableBalances,
    this.walletAddress,
  }) : availableBalances = availableBalances ?? List<Balance>.empty();

  bool get tokenSelected {
    return selectedTokenType != null;
  }

  void updateTokenType(TokenType tokenType) {
    Balance? balance = _tryFindBalanceForTokenType(tokenType);
    sendTokenAmount = TokenAmount(
      tokenDenomination: tokenType.lowestTokenDenomination,
      amount: Decimal.zero,
    );
    availableTokenAmount = TokenAmount(
      tokenDenomination: tokenType.lowestTokenDenomination,
      amount: balance != null ? Decimal.parse(balance.amount) : Decimal.zero,
    );
    selectedTokenType = tokenType;
    amountValueTextController.text = '';
    validate();
    notifyListeners();
  }

  Balance? _tryFindBalanceForTokenType(TokenType tokenType) {
    try {
      Balance balance = availableBalances.firstWhere((Balance balance) {
        return balance.denom == tokenType.lowestTokenDenomination.name;
      });
      return balance;
    } catch (_) {
      // Do nothing if balance not found
    }
  }

  void updateAmountValue(String value) {
    if (sendTokenAmount != null) {
      sendTokenAmount!.amount = value.isEmpty ? Decimal.zero : Decimal.parse(value);
    }
    if (amountValueTextController.text != value) {
      amountValueTextController.text = value == '0' ? '' : value;
    }
    validate();
    notifyListeners();
  }

  void updateTokenDenomination(TokenDenomination tokenDenomination) {
    sendTokenAmount?.tokenDenomination = tokenDenomination;
    availableTokenAmount?.tokenDenomination = tokenDenomination;
    String actualBalance = sendTokenAmount?.amount.toString() ?? '';
    amountValueTextController.text = actualBalance;
    notifyListeners();
  }

  String? validate() {
    String? errorMessage = _getErrorMessage();
    setErrorMessage(errorMessage);
    return errorMessage;
  }

  String? _getErrorMessage() {
    if (walletAddress == null) {
      return 'Enter the sender\'s address to select a token';
    } else if (selectedTokenType == null) {
      return 'Token is not selected';
    } else if (sendTokenAmount!.compareTo(availableTokenAmount!, selectedTokenType!.lowestTokenDenomination) == -1) {
      return 'Not enough tokens';
    }
  }

  void setErrorMessage(String? message) {
    errorMessageNotifier.value = message;
  }

  TokenAmount? save() {
    return sendTokenAmount;
  }
}
