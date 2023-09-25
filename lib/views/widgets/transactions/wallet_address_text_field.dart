import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class WalletAddressTextField extends StatefulWidget {
  final String label;
  final ValueChanged<WalletAddress?> onChanged;
  final bool disabledBool;
  final WalletAddress? defaultWalletAddress;

  const WalletAddressTextField({
    required this.label,
    required this.onChanged,
    this.disabledBool = false,
    this.defaultWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletAddressTextField();
}

class _WalletAddressTextField extends State<WalletAddressTextField> {
  final GlobalKey<FormFieldState<WalletAddress>> formFieldKey = GlobalKey<FormFieldState<WalletAddress>>();
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<WalletAddress?> walletAddressNotifier = ValueNotifier<WalletAddress?>(null);

  @override
  void initState() {
    super.initState();
    _assignDefaultValues();
  }

  @override
  void dispose() {
    formFieldKey.currentState?.dispose();
    textEditingController.dispose();
    walletAddressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return FormField<WalletAddress>(
      key: formFieldKey,
      validator: (_) => _validateAddress(),
      builder: (FormFieldState<WalletAddress> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TxInputWrapper(
              hasErrors: field.hasError,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ValueListenableBuilder<WalletAddress?>(
                    valueListenable: walletAddressNotifier,
                    builder: (_, WalletAddress? walletAddress, __) {
                      return KiraIdentityAvatar(
                        address: walletAddressNotifier.value?.bech32Address,
                        size: 45,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TxTextField(
                        disabled: widget.disabledBool,
                        maxLines: 1,
                        hasErrors: field.hasError,
                        label: widget.label,
                        textEditingController: textEditingController,
                        onChanged: _handleTextFieldChanged,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (field.errorText != null) ...<Widget>[
              const SizedBox(height: 7),
              Text(
                field.errorText!,
                style: textTheme.caption!.copyWith(color: DesignColors.redStatus1),
              ),
            ],
          ],
        );
      },
    );
  }

  void _assignDefaultValues() {
    if (widget.defaultWalletAddress != null) {
      walletAddressNotifier.value = widget.defaultWalletAddress;
      textEditingController.text = widget.defaultWalletAddress!.bech32Address;
    }
  }

  void _handleTextFieldChanged(String value) {
    WalletAddress? walletAddress = _tryCreateWalletAddress(value);
    walletAddressNotifier.value = walletAddress;

    if (value.isEmpty) {
      formFieldKey.currentState?.reset();
    } else {
      formFieldKey.currentState?.validate();
    }
    widget.onChanged.call(walletAddress);
  }

  String? _validateAddress() {
    String addressText = textEditingController.text;
    WalletAddress? walletAddress = _tryCreateWalletAddress(addressText);
    if (walletAddress == null) {
      return S.of(context).txErrorEnterValidAddress;
    }
    return null;
  }

  WalletAddress? _tryCreateWalletAddress(String? address) {
    if (address == null) {
      return null;
    }
    try {
      return WalletAddress.fromBech32(address);
    } catch (e) {
      return null;
    }
  }
}
