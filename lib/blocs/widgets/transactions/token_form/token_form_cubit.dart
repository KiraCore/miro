import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenFormCubit extends Cubit<TokenFormState> {
  final GlobalKey<FormFieldState<TokenAmountModel>> formFieldKey = GlobalKey<FormFieldState<TokenAmountModel>>();
  final TextEditingController amountTextEditingController = TextEditingController(text: '0');

  TokenFormCubit({
    required TokenAmountModel feeTokenAmountModel,
    BalanceModel? defaultBalanceModel,
    TokenAmountModel? defaultTokenAmountModel,
    TokenDenominationModel? defaultTokenDenominationModel,
  }) : super(TokenFormState.assignDefaults(
          feeTokenAmountModel: feeTokenAmountModel,
          defaultBalanceModel: defaultBalanceModel,
          defaultTokenAmountModel: defaultTokenAmountModel,
          defaultTokenDenominationModel: defaultTokenDenominationModel,
        )) {
    _updateTextFieldValue();
  }

  void clearTokenAmount() {
    emit(state.copyWith(tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: state.tokenAmountModel!.tokenAliasModel)));
    _updateTextFieldValue();
  }

  void notifyTokenAmountTextChanged(String text) {
    TokenAmountModel tokenAmountModel = state.tokenAmountModel!.copy();
    Decimal parsedAmount = Decimal.tryParse(text) ?? Decimal.zero;
    tokenAmountModel.setAmount(parsedAmount, tokenDenominationModel: state.tokenDenominationModel);

    emit(state.copyWith(tokenAmountModel: tokenAmountModel));
    _validateTokenForm();
  }

  void setAllAvailableAmount() {
    emit(state.copyWith(tokenAmountModel: state.availableTokenAmountModel));
    _updateTextFieldValue();
  }

  void updateBalance(BalanceModel balanceModel) {
    TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;

    emit(state.copyWith(
      balanceModel: balanceModel,
      tokenDenominationModel: tokenAliasModel.defaultTokenDenominationModel,
      tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: tokenAliasModel),
    ));
    _updateTextFieldValue();
  }

  void updateTokenDenomination(TokenDenominationModel tokenDenominationModel) {
    emit(state.copyWith(tokenDenominationModel: tokenDenominationModel));
    _updateTextFieldValue();
  }

  void _updateTextFieldValue() {
    bool amountFieldEnabledBool = state.tokenAmountModel != null &&  state.tokenDenominationModel != null;
    if( amountFieldEnabledBool ) {
      Decimal availableAmountText = state.tokenAmountModel!.getAmountInDenomination(state.tokenDenominationModel!);
      amountTextEditingController.text = availableAmountText.toString();
      _validateTokenForm();
    }
  }

  void _validateTokenForm() {
    Future<void>.delayed(Duration.zero, () => formFieldKey.currentState?.validate());
  }
}
