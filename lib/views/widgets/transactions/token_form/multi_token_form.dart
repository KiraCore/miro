import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/pages/transactions/msg_forms/staking_msg_delegate_form/selected_token_list.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_available_amount.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown.dart';
import 'package:shimmer/shimmer.dart';

typedef ValidateCallback = String? Function(TokenAmountModel?);

class MultiTokenForm extends StatefulWidget {
  final String label;
  final void Function(TokenFormState, List<TokenAmountModel>) onChanged;
  final TokenAmountModel feeTokenAmountModel;
  final bool selectableBool;
  final BalanceModel? defaultBalanceModel;
  final TokenAliasModel? defaultTokenAliasModel;
  final TokenAmountModel? defaultTokenAmountModel;
  final TokenDenominationModel? defaultTokenDenominationModel;
  final ValidateCallback? validateCallback;
  final WalletAddress? walletAddress;

  const MultiTokenForm({
    required this.label,
    required this.onChanged,
    required this.feeTokenAmountModel,
    required this.walletAddress,
    this.selectableBool = true,
    this.defaultBalanceModel,
    this.defaultTokenAliasModel,
    this.defaultTokenAmountModel,
    this.defaultTokenDenominationModel,
    this.validateCallback,
    Key? key,
  })  : assert(
          defaultBalanceModel != null || defaultTokenAliasModel != null,
          'defaultBalanceModel or defaultTokenAliasModel must be defined to use this widget',
        ),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenForm();
}

class _TokenForm extends State<MultiTokenForm> {
  late final TokenFormCubit tokenFormCubit;
  List<TokenAmountModel> tokenAmountModels = <TokenAmountModel>[];

  @override
  void initState() {
    super.initState();
    if (widget.defaultBalanceModel != null) {
      tokenFormCubit = TokenFormCubit.fromBalance(
        balanceModel: widget.defaultBalanceModel!,
        feeTokenAmountModel: widget.feeTokenAmountModel,
        walletAddress: widget.walletAddress,
        tokenAmountModel: widget.defaultTokenAmountModel,
        tokenDenominationModel: widget.defaultTokenDenominationModel,
      );
    } else {
      tokenFormCubit = TokenFormCubit.fromTokenAlias(
        tokenAliasModel: widget.defaultTokenAliasModel!,
        feeTokenAmountModel: widget.feeTokenAmountModel,
        walletAddress: widget.walletAddress,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Widget shimmerWidget = Shimmer.fromColors(
      baseColor: DesignColors.grey3,
      highlightColor: DesignColors.grey2,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: DesignColors.grey2,
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(minWidth: 100),
      ),
    );

    return BlocProvider<TokenFormCubit>(
      create: (_) => tokenFormCubit,
      child: BlocConsumer<TokenFormCubit, TokenFormState>(
        listener: (_, TokenFormState tokenFormState) => _notifyTokenAmountChanged(tokenFormState),
        builder: (BuildContext context, TokenFormState tokenFormState) {
          return FormField<TokenAmountModel>(
            key: tokenFormCubit.formFieldKey,
            validator: (_) => _buildErrorMessage(tokenFormState),
            builder: (FormFieldState<TokenAmountModel> formFieldState) {
              bool addButtonDisabledBool = tokenFormState.loadingBool ||
                  formFieldState.hasError ||
                  tokenFormState.tokenAmountModel?.getAmountInLowestDenomination() == Decimal.zero ||
                  _isFormValid(tokenFormState) == false;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectedTokenList(
                    delete: (int i) => setState(() => tokenAmountModels.removeAt(i)),
                    tokenAmountModels: tokenAmountModels,
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: DesignColors.grey3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ColumnRowSwapper(
                          rowMainAxisAlignment: MainAxisAlignment.start,
                          rowCrossAxisAlignment: CrossAxisAlignment.start,
                          columnMainAxisAlignment: MainAxisAlignment.start,
                          columnCrossAxisAlignment: CrossAxisAlignment.start,
                          expandOnRow: true,
                          reverseOnColumn: true,
                          children: <Widget>[
                            if (tokenFormState.loadingBool) ...<Widget>[
                              shimmerWidget,
                              const ColumnRowSpacer(size: 16),
                              shimmerWidget,
                            ] else ...<Widget>[
                              TokenAmountTextField(
                                label: widget.label,
                                errorExistsBool: formFieldState.hasError,
                                disabledBool: widget.walletAddress == null,
                                handleSendAllPressed: _handleSendAllPressed,
                                textEditingController: tokenFormCubit.amountTextEditingController,
                                tokenDenominationModel: tokenFormState.tokenDenominationModel,
                              ),
                              const ColumnRowSpacer(size: 16),
                              TokenDropdown(
                                disabledBool: widget.selectableBool == false,
                                defaultBalanceModel: tokenFormState.balanceModel,
                                senderWalletAddress: widget.walletAddress,
                              ),
                            ],
                          ],
                        ),
                        if (tokenFormState.errorBool) ...<Widget>[
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: tokenFormCubit.init,
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            icon: const Icon(Icons.refresh, color: DesignColors.redStatus1, size: 16),
                            label: Text(
                              S.of(context).txCannotLoadBalancesTryAgain,
                              style: textTheme.caption!.copyWith(color: DesignColors.redStatus1),
                            ),
                          ),
                        ],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TokenAvailableAmount(
                                  formFieldState: formFieldState,
                                  balanceModel: _unlistedBalanceModel,
                                  feeTokenAmountModel: tokenFormState.feeTokenAmountModel,
                                  tokenDenominationModel: tokenFormState.tokenDenominationModel,
                                ),
                                TokenDenominationList(
                                  tokenAliasModel: tokenFormState.balanceModel?.tokenAmountModel.tokenAliasModel,
                                  defaultTokenDenominationModel: tokenFormState.tokenDenominationModel,
                                  onChanged: tokenFormCubit.updateTokenDenomination,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 80,
                              child: KiraOutlinedButton(
                                title: 'ADD',
                                onPressed: addButtonDisabledBool ? null : _handleAddButtonPressed,
                                disabled: addButtonDisabledBool,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _handleAddButtonPressed() {
    _buildTokenAmountModels(tokenFormCubit.state);
    setState(() => tokenFormCubit.amountTextEditingController.text = '0');
  }

  void _buildTokenAmountModels(TokenFormState tokenFormState) {
    TokenAmountModel formTokenAmountModel = tokenFormState.tokenAmountModel!;
    if (tokenAmountModels.isEmpty) {
      setState(() => tokenAmountModels.add(formTokenAmountModel));
    } else {
      bool listModifiedBool = false;
      List<TokenAmountModel> updatedTokenAmountModels = <TokenAmountModel>[];
      for (TokenAmountModel model in tokenAmountModels) {
        if (model.tokenAliasModel.defaultTokenDenominationModel == formTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel) {
          listModifiedBool = true;
          Decimal sumAmount = model.getAmountInLowestDenomination() + formTokenAmountModel.getAmountInLowestDenomination();
          TokenAmountModel sumTokenAmountModel = TokenAmountModel(
            lowestDenominationAmount: sumAmount,
            tokenAliasModel: model.tokenAliasModel,
          );
          updatedTokenAmountModels.add(sumTokenAmountModel);
          break;
        } else {
          updatedTokenAmountModels.add(model);
        }
      }
      if (listModifiedBool) {
        setState(() => tokenAmountModels = updatedTokenAmountModels);
      } else {
        setState(() => tokenAmountModels.add(formTokenAmountModel));
      }
    }
  }

  void _handleSendAllPressed() {
    TokenAmountModel? tokenAmountModel = _unlistedTokenAmountModel;
    TokenDenominationModel? tokenDenominationModel = tokenFormCubit.state.tokenDenominationModel;
    Decimal? tokenAmount = tokenAmountModel?.getAmountInDenomination(tokenDenominationModel!);
    String displayedAmount = TxUtils.buildAmountString(tokenAmount.toString(), tokenDenominationModel);
    tokenFormCubit.amountTextEditingController.text = displayedAmount;
  }

  BalanceModel? get _unlistedBalanceModel {
    TokenDenominationModel tokenDenominationModel = tokenFormCubit.state.tokenDenominationModel!;
    for (TokenAmountModel model in tokenAmountModels) {
      if (model.tokenAliasModel.tokenDenominations.contains(tokenDenominationModel)) {
        TokenAmountModel listedTokenAmountModel = model;
        Decimal tokenAmountDifference = listedTokenAmountModel.getAmountInLowestDenomination();
        Decimal availableTokenAmount = tokenFormCubit.state.availableTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;
        Decimal finalAmount = availableTokenAmount - tokenAmountDifference;
        return BalanceModel(tokenAmountModel: TokenAmountModel(lowestDenominationAmount: finalAmount, tokenAliasModel: listedTokenAmountModel.tokenAliasModel));
      }
    }
    return tokenFormCubit.state.balanceModel;
  }

  TokenAmountModel? get _unlistedTokenAmountModel {
    BalanceModel? balanceModel = _unlistedBalanceModel;
    TokenAmountModel? tokenAmountModel = balanceModel?.tokenAmountModel;
    if (tokenAmountModel != null) {
      tokenAmountModel -= widget.feeTokenAmountModel;
    }
    return tokenAmountModel;
  }

  void _notifyTokenAmountChanged(TokenFormState tokenFormState) {
    bool formValidBool = _isFormValid(tokenFormState);
    if (formValidBool) {
      widget.onChanged(tokenFormState, tokenAmountModels);
    } else if (tokenFormState.tokenAmountModel != null) {
      TokenFormState errorTokenFormState = tokenFormState.copyWith(
        tokenAmountModel: TokenAmountModel(lowestDenominationAmount: Decimal.zero, tokenAliasModel: tokenFormState.tokenAmountModel!.tokenAliasModel),
        tokenDenominationModel: tokenFormState.tokenDenominationModel,
      );
      widget.onChanged(errorTokenFormState, tokenAmountModels);
    }
  }

  bool _isFormValid(TokenFormState tokenFormState) {
    String? errorMessage = _buildErrorMessage(tokenFormState);
    return errorMessage == null;
  }

  String? _buildErrorMessage(TokenFormState tokenFormState) {
    TokenAmountModel? selectedTokenAmountModel = tokenFormState.tokenAmountModel;
    TokenAmountModel? availableTokenAmountModel = _unlistedBalanceModel?.tokenAmountModel;
    if (availableTokenAmountModel != null) {
      availableTokenAmountModel -= widget.feeTokenAmountModel;
    }

    Decimal selectedTokenAmount = selectedTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;
    Decimal availableTokenAmount = availableTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;

    if (availableTokenAmount < selectedTokenAmount) {
      return S.of(context).txErrorNotEnoughTokens;
    } else if (selectedTokenAmountModel == null || availableTokenAmountModel == null) {
      return S.of(context).txPleaseSelectToken;
    } else if (widget.validateCallback != null) {
      return widget.validateCallback!(selectedTokenAmountModel);
    } else {
      return null;
    }
  }
}
