import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/transactions/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form_info.dart';

class TokenForm extends StatefulWidget {
  final ValueChanged<TokenFormState> onChanged;
  final TokenAmountModel feeTokenAmountModel;
  final BalanceModel? defaultBalanceModel;
  final TokenAmountModel? defaultTokenAmountModel;
  final TokenDenominationModel? defaultTokenDenominationModel;
  final WalletAddress? walletAddress;

  const TokenForm({
    required this.onChanged,
    required this.feeTokenAmountModel,
    this.defaultBalanceModel,
    this.defaultTokenAmountModel,
    this.defaultTokenDenominationModel,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenForm();
}

class _TokenForm extends State<TokenForm> {
  late final TokenFormCubit tokenFormCubit = TokenFormCubit(
    feeTokenAmountModel: widget.feeTokenAmountModel,
    defaultBalanceModel: widget.defaultBalanceModel,
    defaultTokenAmountModel: widget.defaultTokenAmountModel,
    defaultTokenDenominationModel: widget.defaultTokenDenominationModel,
  );

  @override
  Widget build(BuildContext context) {
    bool disabledBool = widget.walletAddress == null;

    return BlocProvider<TokenFormCubit>(
      create: (_) => tokenFormCubit,
      child: BlocConsumer<TokenFormCubit, TokenFormState>(
        listener: (_, TokenFormState tokenFormState) => widget.onChanged(tokenFormState),
        builder: (BuildContext context, TokenFormState tokenFormState) {
          return FormField<TokenAmountModel>(
            key: tokenFormCubit.formFieldKey,
            validator: (_) => _validate(tokenFormState),
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
                      TokenAmountTextField(
                        errorExistsBool: formFieldState.hasError,
                        disabledBool: disabledBool,
                        textEditingController: tokenFormCubit.amountTextEditingController,
                        tokenDenominationModel: tokenFormState.tokenDenominationModel,
                      ),
                      const ColumnRowSpacer(size: 16),
                      TokenDropdown(
                        disabledBool: disabledBool,
                        defaultBalanceModel: tokenFormState.balanceModel,
                        walletAddress: widget.walletAddress,
                      ),
                    ],
                  ),
                  TokenFormInfo(
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

  String? _validate(TokenFormState tokenFormState) {
    TokenAmountModel? selectedTokenAmountModel = tokenFormState.tokenAmountModel;
    TokenAmountModel? availableTokenAmountModel = tokenFormState.availableTokenAmountModel;

    Decimal selectedTokenAmount = selectedTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;
    Decimal availableTokenAmount = availableTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;

    if (availableTokenAmount < selectedTokenAmount) {
      return S.of(context).txErrorNotEnoughTokens;
    } else if (selectedTokenAmountModel == null || availableTokenAmountModel == null) {
      return S.of(context).txPleaseSelectToken;
    } else {
      return null;
    }
  }
}
