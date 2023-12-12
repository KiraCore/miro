import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class IRMsgRequestVerificationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TokenAmountModel feeTokenAmountModel;
  final TokenAmountModel minTipTokenAmountModel;
  final IRMsgRequestVerificationFormModel irMsgRequestVerificationFormModel;

  const IRMsgRequestVerificationForm({
    required this.formKey,
    required this.feeTokenAmountModel,
    required this.minTipTokenAmountModel,
    required this.irMsgRequestVerificationFormModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgRequestVerificationForm();
}

class _IRMsgRequestVerificationForm extends State<IRMsgRequestVerificationForm> {
  final TextEditingController memoTextEditingController = TextEditingController();
  final TextEditingController recordIdTextEditingController = TextEditingController();
  final TextEditingController recordKeyTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _assignInitialValues();
  }

  @override
  void dispose() {
    memoTextEditingController.dispose();
    recordIdTextEditingController.dispose();
    recordKeyTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WalletAddressTextField(
            label: S.of(context).txHintSendFrom,
            disabledBool: true,
            onChanged: _handleRequesterAddressChanged,
            defaultWalletAddress: widget.irMsgRequestVerificationFormModel.requesterWalletAddress,
          ),
          const SizedBox(height: 14),
          WalletAddressTextField(
            label: S.of(context).txHintSendTo,
            onChanged: _handleVerifierAddressChanged,
            defaultWalletAddress: widget.irMsgRequestVerificationFormModel.verifierWalletAddress,
          ),
          const SizedBox(height: 14),
          TokenForm(
            label: S.of(context).irTxHintTip,
            selectableBool: false,
            defaultBalanceModel: widget.irMsgRequestVerificationFormModel.balanceModel,
            initialFilterOption: BalancesFilterOptions.filterByDefaultToken,
            defaultTokenAmountModel: widget.irMsgRequestVerificationFormModel.tipTokenAmountModel,
            defaultTokenDenominationModel: widget.irMsgRequestVerificationFormModel.tokenDenominationModel,
            feeTokenAmountModel: widget.feeTokenAmountModel,
            onChanged: _handleTipTokenAmountChanged,
            walletAddress: widget.irMsgRequestVerificationFormModel.requesterWalletAddress,
            validateCallback: _validateTipAmount,
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
  }

  void _assignInitialValues() {
    recordIdTextEditingController.text = widget.irMsgRequestVerificationFormModel.irRecordModel.id;
    recordKeyTextEditingController.text = widget.irMsgRequestVerificationFormModel.irRecordModel.key;
    memoTextEditingController.text = widget.irMsgRequestVerificationFormModel.memo;
  }

  void _handleRequesterAddressChanged(WalletAddress? walletAddress) {
    widget.irMsgRequestVerificationFormModel.requesterWalletAddress = walletAddress;
  }

  void _handleVerifierAddressChanged(WalletAddress? walletAddress) {
    widget.irMsgRequestVerificationFormModel.verifierWalletAddress = walletAddress;
  }

  void _handleTipTokenAmountChanged(TokenFormState tokenFormState) {
    widget.irMsgRequestVerificationFormModel.balanceModel = tokenFormState.balanceModel;
    widget.irMsgRequestVerificationFormModel.tipTokenAmountModel = tokenFormState.tokenAmountModel;
    widget.irMsgRequestVerificationFormModel.tokenDenominationModel = tokenFormState.tokenDenominationModel;
  }

  String? _validateTipAmount(TokenAmountModel? tokenAmountModel) {
    if (tokenAmountModel!.getAmountInLowestDenomination() < widget.minTipTokenAmountModel.getAmountInLowestDenomination()) {
      return S.of(context).irTxErrorTipMustBeGreater(widget.minTipTokenAmountModel.toString());
    } else {
      return null;
    }
  }

  void _handleMemoChanged(String memo) {
    widget.irMsgRequestVerificationFormModel.memo = memo;
  }
}
