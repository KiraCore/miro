import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_send_form/msg_send_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/wallet_address_text_field.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';

class MsgSendForm extends StatefulWidget {
  final MsgSendFormController msgSendFormController;
  final MsgFormType msgFormType;
  final String feeValue;
  final TokenAlias? tokenAlias;

  const MsgSendForm({
    required this.msgSendFormController,
    required this.msgFormType,
    required this.feeValue,
    this.tokenAlias,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendForm();
}

class _MsgSendForm extends State<MsgSendForm> {

  @override
  void initState() {
    super.initState();
    widget.msgSendFormController.setSenderWalletAddress(_getInitialSenderWalletAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.msgSendFormController.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WalletAddressTextField(
            disabled: widget.msgFormType == MsgFormType.create,
            initialWalletAddress: _getInitialSenderWalletAddress(),
            onChanged: _handleSenderAddressChanged,
            label: 'Send from',
          ),
          const SizedBox(height: 14),
          WalletAddressTextField(
            disabled: false,
            onChanged: _handleRecipientAddressChanged,
            label: 'Send to',
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<WalletAddress?>(
            valueListenable: widget.msgSendFormController.msgSendFormModel.fromWalletAddressNotifier,
            builder: (_, WalletAddress? senderWalletAddress, ___) {
              return TokenSection(
                disabled: senderWalletAddress == null,
                senderWalletAddress: senderWalletAddress,
                msgFormType: widget.msgFormType,
                onChanged: _handleTokenAmountChanged,
              );
            },
          ),
          const SizedBox(height: 14),
          DecoratedInput(
            child: TextFormField(
              controller: widget.msgSendFormController.msgSendFormModel.memoTextEditingController,
              maxLength: 200,
              decoration: const InputDecoration(
                label: Text(
                  'Memo',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSenderAddressChanged(WalletAddress? walletAddress) {
    widget.msgSendFormController.setSenderWalletAddress(walletAddress);
  }

  void _handleRecipientAddressChanged(WalletAddress? walletAddress) {
    widget.msgSendFormController.setRecipientWalletAddress(walletAddress);
  }

  void _handleTokenAmountChanged(TokenAmount? tokenAmount) {
    widget.msgSendFormController.setTokenAmount(tokenAmount);
  }

  WalletAddress? _getInitialSenderWalletAddress() {
    if (widget.msgFormType == MsgFormType.create) {
      Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
      return wallet.address;
    }
    return null;
  }
}
