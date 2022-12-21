import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class WalletAddressTextField extends StatefulWidget {
  final String label;
  final ValueChanged<WalletAddress?> onChanged;
  final bool disabled;
  final WalletAddress? initialWalletAddress;

  const WalletAddressTextField({
    required this.label,
    required this.onChanged,
    this.disabled = false,
    this.initialWalletAddress,
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
    if (widget.initialWalletAddress != null) {
      walletAddressNotifier.value = widget.initialWalletAddress;
      textEditingController.text = widget.initialWalletAddress!.bech32Address;
      widget.onChanged.call(widget.initialWalletAddress!);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool disabled = widget.initialWalletAddress != null;

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
                        disabled: disabled,
                        maxLines: const ResponsiveValue<int>(
                          largeScreen: 1,
                          mediumScreen: 1,
                          smallScreen: 2,
                        ).get(context),
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
                style: textTheme.caption!.copyWith(
                  color: DesignColors.red_100,
                ),
              ),
            ],
          ],
        );
      },
    );
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
      return 'Please enter a valid address';
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
