import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class StakingMsgDelegateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  StakingMsgDelegateForm({
    required this.formKey,
    required this.stakingMsgDelegateFormModel,
    required this.feeTokenAmountModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StakingMsgDelegateForm> createState() => _StakingMsgDelegateFormState();
}

class _StakingMsgDelegateFormState extends State<StakingMsgDelegateForm> {
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
      bloc: widget.authCubit,
      builder: (BuildContext context, Wallet? wallet) {
        return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              WalletAddressTextField(
                label: S.of(context).txHintSendFrom,
                disabledBool: true,
                onChanged: _handleDelegatorAddressChanged,
                defaultWalletAddress: widget.stakingMsgDelegateFormModel.delegatorWalletAddress,
              ),
              const SizedBox(height: 14),
              WalletAddressTextField(
                label: S.of(context).txHintSendTo,
                disabledBool: true,
                onChanged: _handleValidatorAddressChanged,
                defaultWalletAddress: widget.stakingMsgDelegateFormModel.valoperWalletAddress,
              ),
              const SizedBox(height: 14),
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
                    TokenForm(
                      feeTokenAmountModel: widget.feeTokenAmountModel,
                      onChanged: _handleTokenAmountChanged,
                      label: S.of(context).stakingTxAmountToStake,
                      defaultTokenAliasModel: widget.stakingMsgDelegateFormModel.tokenAliasModel,
                      defaultBalanceModel: widget.stakingMsgDelegateFormModel.balanceModel,
                      defaultTokenAmountModel: widget.stakingMsgDelegateFormModel.tokenAmountModels?.first,
                      defaultTokenDenominationModel: widget.stakingMsgDelegateFormModel.tokenDenominationModel,
                      receiverWalletAddress: widget.stakingMsgDelegateFormModel.validatorWalletAddress,
                      senderWalletAddress: wallet!.address,
                    ),
                  ],
                ),
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

  void _handleValidatorAddressChanged(WalletAddress? walletAddress) {
    widget.stakingMsgDelegateFormModel.validatorWalletAddress = walletAddress;
  }

  void _handleTokenAmountChanged(TokenFormState tokenFormState) {
    widget.stakingMsgDelegateFormModel.balanceModel = tokenFormState.balanceModel;
    widget.stakingMsgDelegateFormModel.tokenDenominationModel = tokenFormState.tokenDenominationModel;
    if (tokenFormState.tokenAmountModel != null && tokenFormState.tokenAmountModel?.getAmountInLowestDenomination() != Decimal.zero) {
      widget.stakingMsgDelegateFormModel.tokenAmountModels = <TokenAmountModel>[tokenFormState.tokenAmountModel!];
    } else {
      widget.stakingMsgDelegateFormModel.tokenAmountModels = null;
    }
  }

  void _handleMemoChanged(String memo) {
    widget.stakingMsgDelegateFormModel.memo = memo;
  }
}
