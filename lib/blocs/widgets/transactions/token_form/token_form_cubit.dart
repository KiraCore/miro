import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';

class TokenFormCubit extends Cubit<TokenFormState> {
  final GlobalKey<FormFieldState<TokenAmountModel>> formFieldKey = GlobalKey<FormFieldState<TokenAmountModel>>();
  final QueryBalanceService queryBalanceService = QueryBalanceService();
  final TextEditingController amountTextEditingController = TextEditingController(text: '0');

  TokenFormCubit.fromBalance({
    required TokenAmountModel feeTokenAmountModel,
    required BalanceModel balanceModel,
    required WalletAddress? walletAddress,
    TokenAmountModel? tokenAmountModel,
    TokenDenominationModel? tokenDenominationModel,
  }) : super(TokenFormState.fromBalance(
          balanceModel: balanceModel,
          feeTokenAmountModel: feeTokenAmountModel,
          walletAddress: walletAddress,
          tokenAmountModel: tokenAmountModel,
          tokenDenominationModel: tokenDenominationModel,
        )) {
    init();
  }

  TokenFormCubit.fromFirstBalance({
    required TokenAmountModel feeTokenAmountModel,
    required WalletAddress? walletAddress,
    bool? derivedTokensBool,
    FilterOption<BalanceModel>? initialFilterOption,
  }) : super(TokenFormState.fromFirstBalance(
          feeTokenAmountModel: feeTokenAmountModel,
          walletAddress: walletAddress,
          loadingBool: true,
        )) {
    init(derivedTokensBool: derivedTokensBool, filterOption: initialFilterOption);
  }

  void init({bool? derivedTokensBool, FilterOption<BalanceModel>? filterOption}) {
    bool balanceExistsBool = state.balanceModel != null;
    if (balanceExistsBool) {
      _updateTextFieldValue();
    } else {
      _initWithFirstBalance(derivedTokensBool, filterOption);
    }
  }

  @override
  Future<void> close() {
    formFieldKey.currentState?.dispose();
    amountTextEditingController.dispose();
    return super.close();
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
      loadingBool: false,
      errorBool: false,
      balanceModel: balanceModel,
      tokenDenominationModel: tokenAliasModel.defaultTokenDenominationModel,
      tokenAmountModel: TokenAmountModel.zero(tokenAliasModel: tokenAliasModel),
    ));
    _updateTextFieldValue();
  }

  void updateTokenDenomination(TokenDenominationModel tokenDenominationModel) {
    emit(state.copyWith(
      loadingBool: false,
      tokenDenominationModel: tokenDenominationModel,
    ));
    _updateTextFieldValue();
  }

  Future<void> _initWithFirstBalance(bool? derivedTokensBool, FilterOption<BalanceModel>? filterOption) async {
    try {
      PageData<BalanceModel> balanceModelData = await queryBalanceService.getBalanceModelList(QueryBalanceReq(
        address: state.walletAddress!.bech32Address,
        offset: 0,
        limit: 500,
        derived: derivedTokensBool,
      ));
      List<BalanceModel> balanceModelList = balanceModelData.listItems;

      if (filterOption != null) {
        balanceModelList = balanceModelList.where(filterOption.filterComparator).toList();
      }

      BalanceModel initialBalanceModel = balanceModelList.first;
      updateBalance(initialBalanceModel);
    } catch (_) {
      emit(state.copyWith(errorBool: true));
    }
  }

  void _updateTextFieldValue() {
    bool amountFieldEnabledBool = state.tokenAmountModel != null && state.tokenDenominationModel != null;
    if (amountFieldEnabledBool) {
      Decimal availableAmount = state.tokenAmountModel!.getAmountInDenomination(state.tokenDenominationModel!);
      String displayedAmount = TxUtils.buildAmountString(availableAmount.toString(), state.tokenDenominationModel);
      amountTextEditingController.text = displayedAmount;
      _validateTokenForm();
    }
  }

  void _validateTokenForm() {
    Future<void>.delayed(const Duration(milliseconds: 50), () => formFieldKey.currentState?.validate());
  }
}
