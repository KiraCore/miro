import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_available_amount.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown.dart';

typedef ValidateCallback = String? Function(TokenAmountModel?);

class TokenForm extends StatefulWidget {
  final String label;
  final ValueChanged<TokenFormState> onChanged;
  final TokenAmountModel feeTokenAmountModel;
  final WalletAddress? walletAddress;
  final bool selectableBool;
  final BalanceModel? defaultBalanceModel;
  final FilterOption<BalanceModel>? initialFilterOption;
  final TokenAmountModel? defaultTokenAmountModel;
  final TokenDenominationModel? defaultTokenDenominationModel;
  final ValidateCallback? validateCallback;

  const TokenForm({
    required this.label,
    required this.onChanged,
    required this.feeTokenAmountModel,
    required this.walletAddress,
    this.selectableBool = true,
    this.defaultBalanceModel,
    this.initialFilterOption,
    this.defaultTokenAmountModel,
    this.defaultTokenDenominationModel,
    this.validateCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenForm();
}

class _TokenForm extends State<TokenForm> {
  late final TokenFormCubit tokenFormCubit;

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
      tokenFormCubit = TokenFormCubit.fromFirstBalance(
        feeTokenAmountModel: widget.feeTokenAmountModel,
        initialFilterOption: widget.initialFilterOption,
        walletAddress: widget.walletAddress,
      );
    }
  }

  @override
  void dispose() {
    tokenFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Widget shimmerWidget = const LoadingContainer(
      height: 80,
      circularBorderRadius: 8,
      boxConstraints: BoxConstraints(minWidth: 100),
    );

    return BlocProvider<TokenFormCubit>.value(
      value: tokenFormCubit,
      child: BlocConsumer<TokenFormCubit, TokenFormState>(
        listener: (_, TokenFormState tokenFormState) => _notifyTokenAmountChanged(tokenFormState),
        builder: (BuildContext context, TokenFormState tokenFormState) {
          return FormField<TokenAmountModel>(
            key: tokenFormCubit.formFieldKey,
            validator: (_) => _buildErrorMessage(tokenFormState),
            builder: (FormFieldState<TokenAmountModel> formFieldState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          textEditingController: tokenFormCubit.amountTextEditingController,
                          tokenDenominationModel: tokenFormState.tokenDenominationModel,
                        ),
                        const ColumnRowSpacer(size: 16),
                        TokenDropdown(
                          disabledBool: widget.selectableBool == false,
                          defaultBalanceModel: tokenFormState.balanceModel,
                          initialFilterOption: widget.initialFilterOption,
                          walletAddress: widget.walletAddress,
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
                        S.of(context).txErrorCannotLoadBalances,
                        style: textTheme.bodySmall!.copyWith(color: DesignColors.redStatus1),
                      ),
                    ),
                  ],
                  TokenAvailableAmount(
                    formFieldState: formFieldState,
                    balanceModel: tokenFormState.balanceModel,
                    feeTokenAmountModel: tokenFormState.feeTokenAmountModel,
                    tokenDenominationModel: tokenFormState.tokenDenominationModel,
                  ),
                  TokenDenominationList(
                    tokenAliasModel: tokenFormState.balanceModel?.tokenAmountModel.tokenAliasModel,
                    defaultTokenDenominationModel: tokenFormState.tokenDenominationModel,
                    onChanged: tokenFormCubit.updateTokenDenomination,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _notifyTokenAmountChanged(TokenFormState tokenFormState) {
    bool formValidBool = _isFormValid(tokenFormState);
    if (formValidBool) {
      widget.onChanged(tokenFormState);
    } else if (tokenFormState.tokenAmountModel != null) {
      TokenFormState errorTokenFormState = tokenFormState.copyWith(
        tokenAmountModel: TokenAmountModel(defaultDenominationAmount: Decimal.zero, tokenAliasModel: tokenFormState.tokenAmountModel!.tokenAliasModel),
        tokenDenominationModel: tokenFormState.tokenDenominationModel,
      );
      widget.onChanged(errorTokenFormState);
    }
  }

  bool _isFormValid(TokenFormState tokenFormState) {
    String? errorMessage = _buildErrorMessage(tokenFormState);
    return errorMessage == null;
  }

  String? _buildErrorMessage(TokenFormState tokenFormState) {
    TokenAmountModel? selectedTokenAmountModel = tokenFormState.tokenAmountModel;
    TokenAmountModel? availableTokenAmountModel = tokenFormState.availableTokenAmountModel;

    Decimal selectedTokenAmount = selectedTokenAmountModel?.getAmountInDefaultDenomination() ?? Decimal.zero;
    Decimal availableTokenAmount = availableTokenAmountModel?.getAmountInDefaultDenomination() ?? Decimal.zero;

    if (selectedTokenAmount == Decimal.zero) {
      return null;
    } else if (availableTokenAmount < selectedTokenAmount) {
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
