import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_state.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenFormCubit extends Cubit<TokenFormState> {
  static const String _emptyTokenAmount = '0';

  final GlobalKey<FormFieldState<TokenAmountModel>> formFieldKey = GlobalKey<FormFieldState<TokenAmountModel>>();
  final TextEditingController amountTextEditingController = TextEditingController(text: _emptyTokenAmount);

  final ValueNotifier<TokenAmountModel?> tokenAmountModelNotifier = ValueNotifier<TokenAmountModel?>(null);
  final ValueNotifier<TotalBalanceModel?> totalBalanceModelNotifier = ValueNotifier<TotalBalanceModel?>(null);
  final ValueNotifier<TokenDenominationModel?> tokenDenominationModelNotifier = ValueNotifier<TokenDenominationModel?>(null);

  final TokenAmountModel feeTokenAmountModel;

  TokenFormCubit({
    required this.feeTokenAmountModel,
    BalanceModel? initialBalanceModel,
  }) : super(const TokenFormState()) {
    if (initialBalanceModel != null) {
      setBalanceModel(initialBalanceModel);
    }
  }

  void setBalanceModel(BalanceModel balanceModel) {
    totalBalanceModelNotifier.value = TotalBalanceModel(
      balanceModel: balanceModel,
      feeTokenAmountModel: feeTokenAmountModel,
    );

    TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;
    tokenDenominationModelNotifier.value = tokenAliasModel.defaultTokenDenominationModel;
    _notifyValueChanged(TokenAmountModel.zero(tokenAliasModel: tokenAliasModel));
    setTokenAmountValue(_emptyTokenAmount, shouldUpdateTextField: true);
  }

  void setTokenDenominationModel(TokenDenominationModel tokenDenominationModel) {
    tokenDenominationModelNotifier.value = tokenDenominationModel;
    TokenAmountModel tokenAmountModel = tokenAmountModelNotifier.value!;

    Decimal amountInNewDenomination = tokenAmountModel.getAmountInDenomination(tokenDenominationModel);
    setTokenAmountValue(amountInNewDenomination.toString(), shouldUpdateTextField: true);
  }

  void setAllAvailableAmount() {
    TokenDenominationModel tokenDenominationModel = tokenDenominationModelNotifier.value!;
    TotalBalanceModel totalBalanceModel = totalBalanceModelNotifier.value!;

    TokenAmountModel availableTokenAmountModel = totalBalanceModel.availableTokenAmountModel;
    String availableAmountText = availableTokenAmountModel.getAmountInDenomination(tokenDenominationModel).toString();
    setTokenAmountValue(availableAmountText, shouldUpdateTextField: true);
  }

  void clearTokenAmount() {
    setTokenAmountValue(_emptyTokenAmount, shouldUpdateTextField: true);
  }

  void setTokenAmountValue(String amountText, {bool shouldUpdateTextField = false}) {
    TokenAmountModel? tokenAmountModel = tokenAmountModelNotifier.value;
    try {
      Decimal parsedAmount = Decimal.parse(amountText);
      tokenAmountModel?.setAmount(parsedAmount, tokenDenominationModel: tokenDenominationModelNotifier.value);
    } catch (_) {
      tokenAmountModel?.setAmount(Decimal.zero);
    }
    if (shouldUpdateTextField) {
      amountTextEditingController.text = amountText;
    }
    _notifyValueChanged(tokenAmountModel);
  }

  void _notifyValueChanged(TokenAmountModel? tokenAmountModel) {
    tokenAmountModelNotifier.value = tokenAmountModel;
    if (isFormValid && tokenAmountModel?.getAmountInLowestDenomination() != Decimal.zero) {
      emit(TokenFormState(tokenAmountModel: tokenAmountModel));
    } else {
      emit(const TokenFormState(tokenAmountModel: null));
    }
  }

  bool get isFormValid => formFieldKey.currentState?.validate() ?? false;
}
