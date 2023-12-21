import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_mode.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form.dart';
import 'package:miro/views/widgets/transactions/tx_validator_preview.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class StakingMsgDelegateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool Function(BalanceModel) initialFilterComparator;
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const StakingMsgDelegateForm({
    required this.formKey,
    required this.initialFilterComparator,
    required this.stakingMsgDelegateFormModel,
    required this.validatorSimplifiedModel,
    required this.feeTokenAmountModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StakingMsgDelegateForm> createState() => _StakingMsgDelegateFormState();
}

class _StakingMsgDelegateFormState extends State<StakingMsgDelegateForm> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final TextEditingController memoTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _assignDefaultValues();
  }

  @override
  void dispose() {
    memoTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, Wallet?>(
      bloc: authCubit,
      builder: (BuildContext context, Wallet? wallet) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              WalletAddressTextField(
                label: S.of(context).txHintStakeBy,
                disabledBool: true,
                onChanged: _handleDelegatorAddressChanged,
                defaultWalletAddress: widget.stakingMsgDelegateFormModel.delegatorWalletAddress,
              ),
              const SizedBox(height: 14),
              TxValidatorPreview(
                validatorSimplifiedModel: widget.validatorSimplifiedModel,
                label: S.of(context).txHintStakeOn,
              ),
              const SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TokenForm(
                    feeTokenAmountModel: widget.feeTokenAmountModel,
                    onChanged: _handleTokenAmountChanged,
                    label: S.of(context).stakingTxAmountToStake,
                    initialFilterOption: FilterOption<BalanceModel>(
                      id: 'delegate',
                      filterComparator: widget.initialFilterComparator,
                      filterMode: FilterMode.and,
                    ),
                    defaultBalanceModel: widget.stakingMsgDelegateFormModel.balanceModel,
                    defaultTokenAmountModel: widget.stakingMsgDelegateFormModel.tokenAmountModels?.first,
                    defaultTokenDenominationModel: widget.stakingMsgDelegateFormModel.tokenDenominationModel,
                    walletAddress: wallet!.address,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              MemoTextField(
                label: S.of(context).txHintMemo,
                onChanged: _handleMemoChanged,
                memoTextEditingController: memoTextEditingController,
              ),
            ],
          ),
        );
      },
    );
  }

  void _assignDefaultValues() {
    memoTextEditingController.text = widget.stakingMsgDelegateFormModel.memo;
  }

  void _handleDelegatorAddressChanged(WalletAddress? walletAddress) {
    widget.stakingMsgDelegateFormModel.delegatorWalletAddress = walletAddress;
  }

  void _handleTokenAmountChanged(TokenFormState tokenFormState) {
    widget.stakingMsgDelegateFormModel.balanceModel = tokenFormState.balanceModel;
    widget.stakingMsgDelegateFormModel.tokenDenominationModel = tokenFormState.tokenDenominationModel;
    if (tokenFormState.tokenAmountModel != null && tokenFormState.tokenAmountModel?.getAmountInDefaultDenomination() != Decimal.zero) {
      widget.stakingMsgDelegateFormModel.tokenAmountModels = <TokenAmountModel>[tokenFormState.tokenAmountModel!];
    } else {
      widget.stakingMsgDelegateFormModel.tokenAmountModels = null;
    }
  }

  void _handleMemoChanged(String memo) {
    widget.stakingMsgDelegateFormModel.memo = memo;
  }
}
