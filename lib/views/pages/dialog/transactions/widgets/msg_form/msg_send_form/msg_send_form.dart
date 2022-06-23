import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_send_form/msg_send_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

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
  final TransactionsService transactionsService = globalLocator<TransactionsService>();

  @override
  void initState() {
    if (widget.msgFormType == MsgFormType.create) {
      Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
      widget.msgSendFormController.updateSenderAddress(wallet.address);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.msgSendFormController.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DecoratedInput(
            disabled: widget.msgFormType == MsgFormType.create,
            leading: ValueListenableBuilder<WalletAddress?>(
              valueListenable: widget.msgSendFormController.fromAddress,
              builder: _buildKiraIdentityAvatar,
            ),
            child: TextFormField(
              onChanged: _onSenderAddressChanged,
              enabled: widget.msgFormType != MsgFormType.create,
              initialValue: widget.msgSendFormController.fromAddress.value?.bech32Address,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _getValidateAddressErrorMessage,
              decoration: const InputDecoration(
                label: Text(
                  'Send from',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          DecoratedInput(
            leading: ValueListenableBuilder<WalletAddress?>(
              valueListenable: widget.msgSendFormController.toAddress,
              builder: _buildKiraIdentityAvatar,
            ),
            child: TextFormField(
              onChanged: _onRecipientAddressChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _getValidateAddressErrorMessage,
              decoration: const InputDecoration(
                label: Text(
                  'Send to',
                  style: TextStyle(color: DesignColors.gray2_100),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<WalletAddress?>(
            valueListenable: widget.msgSendFormController.fromAddress,
            builder: (_, __, ___) => _buildTokenSection(),
          ),
          const SizedBox(height: 14),
          DecoratedInput(
            child: TextFormField(
              controller: widget.msgSendFormController.memoTextEditingController,
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

  void _onSenderAddressChanged(String value) {
    try {
      widget.msgSendFormController.updateSenderAddress(WalletAddress.fromBech32(value));
    } catch (_) {
      widget.msgSendFormController.updateSenderAddress(null);
    }
  }

  void _onRecipientAddressChanged(String value) {
    try {
      widget.msgSendFormController.updateRecipientAddress(WalletAddress.fromBech32(value));
    } catch (_) {
      widget.msgSendFormController.updateRecipientAddress(null);
    }
  }

  Widget _buildKiraIdentityAvatar(BuildContext context, WalletAddress? walletAddress, Widget? child) {
    return KiraIdentityAvatar(
      size: 45,
      address: walletAddress?.bech32Address,
    );
  }

  String? _getValidateAddressErrorMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field required';
    }
    try {
      WalletAddress.fromBech32(value);
      return null;
    } catch (e) {
      return 'Invalid address';
    }
  }

  Widget _buildTokenSection() {
    return TokenSection(
      loading: false,
      disabled: widget.msgSendFormController.fromAddress.value != null,
      address: widget.msgSendFormController.fromAddress.value?.bech32Address,
      tokenSectionController: widget.msgSendFormController.tokenSectionController,
      initialTokenType: widget.tokenAlias != null ? TokenType.fromTokenAlias(widget.tokenAlias!) : null,
      msgFormType: widget.msgFormType,
      onChanged: widget.msgSendFormController.onTokenAmountChanged,
    );
  }
}
