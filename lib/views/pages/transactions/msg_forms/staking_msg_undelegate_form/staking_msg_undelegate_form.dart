import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_undelegate_form_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form.dart';
import 'package:miro/views/widgets/transactions/tx_validator_preview.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class StakingMsgUndelegateForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final StakingMsgUndelegateFormModel stakingMsgUndelegateFormModel;
  final TokenAmountModel feeTokenAmountModel;
  final ValidatorSimplifiedModel validatorSimplifiedModel;

  const StakingMsgUndelegateForm({
    required this.formKey,
    required this.stakingMsgUndelegateFormModel,
    required this.feeTokenAmountModel,
    required this.validatorSimplifiedModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StakingMsgUndelegateForm> createState() => _StakingMsgUndelegateFormState();
}

class _StakingMsgUndelegateFormState extends State<StakingMsgUndelegateForm> {
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
                label: S.of(context).txHintUnstakeBy,
                disabledBool: true,
                onChanged: _handleDelegatorAddressChanged,
                defaultWalletAddress: widget.stakingMsgUndelegateFormModel.delegatorWalletAddress,
              ),
              const SizedBox(height: 14),
              TxValidatorPreview(
                validatorSimplifiedModel: widget.validatorSimplifiedModel,
                label: S.of(context).txHintUnstakeFrom,
              ),
              const SizedBox(height: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TokenForm(
                    feeTokenAmountModel: widget.feeTokenAmountModel,
                    onChanged: _handleTokenAmountChanged,
                    label: S.of(context).stakingTxAmountToUnstake,
                    derivedTokensBool: true,
                    defaultBalanceModel: widget.stakingMsgUndelegateFormModel.balanceModel,
                    defaultTokenAmountModel: widget.stakingMsgUndelegateFormModel.tokenAmountModels?.first,
                    defaultTokenDenominationModel: widget.stakingMsgUndelegateFormModel.tokenDenominationModel,
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
    memoTextEditingController.text = widget.stakingMsgUndelegateFormModel.memo;
  }

  void _handleDelegatorAddressChanged(WalletAddress? walletAddress) {
    widget.stakingMsgUndelegateFormModel.delegatorWalletAddress = walletAddress;
  }

  void _handleTokenAmountChanged(TokenFormState tokenFormState) {
    widget.stakingMsgUndelegateFormModel.balanceModel = tokenFormState.balanceModel;
    widget.stakingMsgUndelegateFormModel.tokenDenominationModel = tokenFormState.tokenDenominationModel;
    bool tokenAmountModelEmpty = tokenFormState.tokenAmountModel == null || tokenFormState.tokenAmountModel?.getAmountInDefaultDenomination() == Decimal.zero;
    if (tokenAmountModelEmpty) {
      widget.stakingMsgUndelegateFormModel.tokenAmountModels = null;
    } else {
      _updateTokenAmountModels(tokenFormState);
    }
  }

  void _updateTokenAmountModels(TokenFormState tokenFormState) {
    String stakedTokenName = tokenFormState.tokenAmountModel!.tokenAliasModel.name;
    String basicTokenName = stakedTokenName.substring(stakedTokenName.indexOf('/') + 1);
    TokenAmountModel basicTokenAmountModel = TokenAmountModel(
      defaultDenominationAmount: tokenFormState.tokenAmountModel!.getAmountInDefaultDenomination(),
      tokenAliasModel: TokenAliasModel.local(basicTokenName),
    );
    widget.stakingMsgUndelegateFormModel.tokenAmountModels = <TokenAmountModel>[basicTokenAmountModel];
  }

  void _handleMemoChanged(String memo) {
    widget.stakingMsgUndelegateFormModel.memo = memo;
  }
}
