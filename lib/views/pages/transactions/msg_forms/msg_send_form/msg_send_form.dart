import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_state.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_text_field.dart';
import 'package:miro/views/widgets/transactions/token_form/token_form.dart';
import 'package:miro/views/widgets/transactions/wallet_address_text_field.dart';

class MsgSendForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final MsgSendFormModel msgSendFormModel;
  final TokenAmountModel feeTokenAmountModel;

  const MsgSendForm({
    required this.formKey,
    required this.msgSendFormModel,
    required this.feeTokenAmountModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendForm();
}

class _MsgSendForm extends State<MsgSendForm> {
  final TextEditingController memoTextEditingController = TextEditingController();
  final ValueNotifier<WalletAddress?> walletAddressNotifier = ValueNotifier<WalletAddress?>(null);

  @override
  void initState() {
    super.initState();
    _assignDefaultValues();
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
            onChanged: _handleSenderAddressChanged,
            defaultWalletAddress: widget.msgSendFormModel.senderWalletAddress,
          ),
          const SizedBox(height: 14),
          WalletAddressTextField(
            label: S.of(context).txHintSendTo,
            onChanged: _handleRecipientAddressChanged,
            defaultWalletAddress: widget.msgSendFormModel.recipientWalletAddress,
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<WalletAddress?>(
            valueListenable: walletAddressNotifier,
            builder: (_, WalletAddress? walletAddress, __) {
              return TokenForm(
                feeTokenAmountModel: widget.feeTokenAmountModel,
                defaultBalanceModel: widget.msgSendFormModel.balanceModel,
                defaultTokenAmountModel: widget.msgSendFormModel.tokenAmountModel,
                defaultTokenDenominationModel: widget.msgSendFormModel.tokenDenominationModel,
                onChanged: _handleTokenAmountChanged,
                walletAddress: walletAddress,
              );
            },
          ),
          const SizedBox(height: 19),
          MemoTextField(
            onChanged: _handleMemoChanged,
            memoTextEditingController: memoTextEditingController,
          ),
        ],
      ),
    );
  }

  void _assignDefaultValues() {
    memoTextEditingController.text = widget.msgSendFormModel.memo;
    walletAddressNotifier.value = widget.msgSendFormModel.senderWalletAddress;
  }

  void _handleSenderAddressChanged(WalletAddress? walletAddress) {
    walletAddressNotifier.value = walletAddress;
    widget.msgSendFormModel.senderWalletAddress = walletAddress;
  }

  void _handleRecipientAddressChanged(WalletAddress? walletAddress) {
    widget.msgSendFormModel.recipientWalletAddress = walletAddress;
  }

  void _handleTokenAmountChanged(TokenFormState tokenFormState) {
    widget.msgSendFormModel.balanceModel = tokenFormState.balanceModel;
    widget.msgSendFormModel.tokenAmountModel = tokenFormState.tokenAmountModel;
    widget.msgSendFormModel.tokenDenominationModel = tokenFormState.tokenDenominationModel;
  }

  void _handleMemoChanged(String memo) {
    widget.msgSendFormModel.memo = memo;
  }
}
