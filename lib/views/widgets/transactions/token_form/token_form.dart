import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_cubit.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_state.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form_info.dart';

class TokenForm extends StatefulWidget {
  final TokenAmountModel feeTokenAmountModel;
  final ValueChanged<TokenAmountModel?> onChanged;
  final BalanceModel? initialBalanceModel;
  final WalletAddress? walletAddress;

  const TokenForm({
    required this.feeTokenAmountModel,
    required this.onChanged,
    this.initialBalanceModel,
    this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenForm();
}

class _TokenForm extends State<TokenForm> {
  late final TokenFormCubit tokenFormCubit = TokenFormCubit(
    feeTokenAmountModel: widget.feeTokenAmountModel,
    initialBalanceModel: widget.initialBalanceModel,
  );

  late final StreamSubscription<TokenFormState> tokenFormStateSubscription;

  @override
  void initState() {
    super.initState();
    tokenFormStateSubscription = tokenFormCubit.stream.listen((TokenFormState tokenFormState) {
      widget.onChanged(tokenFormState.tokenAmountModel);
    });
  }

  @override
  void dispose() {
    tokenFormStateSubscription.cancel();
    tokenFormCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool disabled = widget.walletAddress == null;

    return BlocProvider<TokenFormCubit>(
      create: (_) => tokenFormCubit,
      child: FormField<TokenAmountModel>(
        key: tokenFormCubit.formFieldKey,
        validator: (_) => _validate(),
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
                    hasErrors: formFieldState.hasError,
                    disabled: disabled,
                    textEditingController: tokenFormCubit.amountTextEditingController,
                    tokenDenominationModelNotifier: tokenFormCubit.tokenDenominationModelNotifier,
                  ),
                  const ColumnRowSpacer(size: 16),
                  TokenDropdown(
                    disabled: disabled,
                    initialBalanceModel: tokenFormCubit.totalBalanceModelNotifier.value?.balanceModel,
                    walletAddress: widget.walletAddress,
                  ),
                ],
              ),
              TokenFormInfo(
                formFieldState: formFieldState,
                totalBalanceModel: tokenFormCubit.totalBalanceModelNotifier.value,
                tokenDenominationModelNotifier: tokenFormCubit.tokenDenominationModelNotifier,
              ),
              ValueListenableBuilder<TotalBalanceModel?>(
                valueListenable: tokenFormCubit.totalBalanceModelNotifier,
                builder: (_, TotalBalanceModel? totalBalanceModel, __) {
                  return TokenDenominationList(tokenAliasModel: totalBalanceModel?.tokenAliasModel);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String? _validate() {
    TokenAmountModel? selectedTokenAmountModel = tokenFormCubit.tokenAmountModelNotifier.value;
    TokenAmountModel? availableTokenAmountModel = tokenFormCubit.totalBalanceModelNotifier.value?.availableTokenAmountModel;

    Decimal selectedTokenAmount = selectedTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;
    Decimal availableTokenAmount = availableTokenAmountModel?.getAmountInLowestDenomination() ?? Decimal.zero;

    if (availableTokenAmount < selectedTokenAmount) {
      return 'Not enough tokens';
    } else if (selectedTokenAmountModel == null || availableTokenAmountModel == null) {
      return 'Please select a token';
    } else {
      return null;
    }
  }
}
