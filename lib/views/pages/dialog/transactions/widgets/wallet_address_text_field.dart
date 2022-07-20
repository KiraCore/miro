import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class WalletAddressTextField extends StatefulWidget {
  final bool disabled;
  final String label;
  final ValueChanged<WalletAddress?> onChanged;
  final WalletAddress? initialWalletAddress;

  const WalletAddressTextField({
    required this.disabled,
    required this.label,
    required this.onChanged,
    this.initialWalletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletAddressTextField();
}

class _WalletAddressTextField extends State<WalletAddressTextField> {
  late final ValueNotifier<WalletAddress?> walletAddressNotifier;

  @override
  void initState() {
    super.initState();
    walletAddressNotifier = ValueNotifier<WalletAddress?>(widget.initialWalletAddress);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedInput(
      disabled: widget.disabled,
      leading: ValueListenableBuilder<WalletAddress?>(
        valueListenable: walletAddressNotifier,
        builder: _buildKiraIdentityAvatar,
      ),
      child: TextFormField(
        onChanged: _handleTextFieldChanged,
        enabled: !widget.disabled,
        initialValue: walletAddressNotifier.value?.bech32Address,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _getErrorMessage,
        decoration: InputDecoration(
          label: Text(
            widget.label,
            style: const TextStyle(color: DesignColors.gray2_100),
          ),
        ),
      ),
    );
  }

  Widget _buildKiraIdentityAvatar(BuildContext context, WalletAddress? walletAddress, Widget? child) {
    return KiraIdentityAvatar(
      size: 45,
      address: walletAddress?.bech32Address,
    );
  }

  void _handleTextFieldChanged(String value) {
    WalletAddress? walletAddress = _tryParseWalletAddress(value);
    _handleWalletAddressChanged(walletAddress);
  }

  void _handleWalletAddressChanged(WalletAddress? walletAddress) {
    walletAddressNotifier.value = walletAddress;
    widget.onChanged.call(walletAddress);
  }

  String? _getErrorMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field required';
    }
    WalletAddress? walletAddress = _tryParseWalletAddress(value);
    if (walletAddress == null) {
      return 'Invalid address';
    }
  }

  WalletAddress? _tryParseWalletAddress(String address) {
    try {
      return WalletAddress.fromBech32(address);
    } catch (_) {
      // Address field is not filled yet
      return null;
    }
  }
}
