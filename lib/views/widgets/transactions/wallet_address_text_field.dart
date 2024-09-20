import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class WalletAddressTextField extends StatefulWidget {
  final String label;
  final ValueChanged<AWalletAddress?> onChanged;
  final bool disabledBool;
  final AWalletAddress? defaultWalletAddress;

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
  final GlobalKey<FormFieldState<AWalletAddress>> formFieldKey = GlobalKey<FormFieldState<AWalletAddress>>();
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<AWalletAddress?> walletAddressNotifier = ValueNotifier<AWalletAddress?>(null);

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

    return FormField<AWalletAddress>(
      key: formFieldKey,
      validator: (_) => _validateAddress(),
      builder: (FormFieldState<AWalletAddress> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TxInputWrapper(
              hasErrors: field.hasError,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ValueListenableBuilder<AWalletAddress?>(
                    valueListenable: walletAddressNotifier,
                    builder: (_, AWalletAddress? walletAddress, __) {
                      return KiraIdentityAvatar(
                        address: walletAddressNotifier.value?.address,
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
                style: textTheme.bodySmall!.copyWith(color: DesignColors.redStatus1),
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
      textEditingController.text = widget.defaultWalletAddress!.address;
    }
  }

  void _handleTextFieldChanged(String value) {
    AWalletAddress? walletAddress = _tryCreateWalletAddress(value);
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
    AWalletAddress? walletAddress = _tryCreateWalletAddress(addressText);
    if (walletAddress == null) {
      return S.of(context).txErrorEnterValidAddress;
    }
    return null;
  }

  AWalletAddress? _tryCreateWalletAddress(String? address) {
    if (address == null) {
      return null;
    }
    try {
      return AWalletAddress.fromAddress(address);
    } catch (e) {
      return null;
    }
  }
}
