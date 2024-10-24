import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/cosmos_wallet_address.dart';
import 'package:miro/shared/models/wallet/address/ethereum_wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
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
  final AuthCubit authCubit = globalLocator<AuthCubit>();

  /// Text controller has ETH, [oppositeAddress] has KIRA, and vice versa.
  final ValueNotifier<String?> oppositeAddressNotifier = ValueNotifier<String?>(null);

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
    oppositeAddressNotifier.dispose();
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
                  KiraIdentityAvatar(
                    address: walletAddressNotifier.value?.address,
                    size: 45,
                  ),
                  const SizedBox(width: 12),
                  BlocConsumer<AuthCubit, Wallet?>(
                    bloc: authCubit,
                    listener: (BuildContext context, Wallet? state) {
                      if (authCubit.isEthereumSession) {
                        _handleTextFieldChanged(
                          textEditingController.text,
                          needOppositeAddressBool: true,
                          walletAddressType: state!.address.type,
                        );
                      }
                    },
                    buildWhen: (Wallet? previous, Wallet? current) => previous?.isEthereum != current?.isEthereum,
                    builder: (BuildContext context, Wallet? state) {
                      return Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TxTextField(
                            disabled: widget.disabledBool,
                            maxLines: 1,
                            hasErrors: field.hasError,
                            label: widget.label,
                            // situationally use the error as subtitle under the text
                            errorText: oppositeAddressNotifier.value,
                            errorStyle: textTheme.bodyMedium!.copyWith(
                              color: DesignColors.grey1,
                            ),
                            textEditingController: textEditingController,
                            onChanged: (String value) => _handleTextFieldChanged(
                              value,
                              // TODO(Mykyta): make `isEthereumSession` as state prop as soon as it's ready
                              needOppositeAddressBool: authCubit.isEthereumSession == true,
                              walletAddressType: state!.address.type,
                            ),
                          ),
                        ),
                      );
                    },
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
      if (authCubit.isEthereumSession) {
        oppositeAddressNotifier.value = widget.defaultWalletAddress!.toOppositeAddressType().address;
      }
    }
  }

  void _handleTextFieldChanged(String value, {required bool needOppositeAddressBool, required WalletAddressType walletAddressType}) {
    AWalletAddress? walletAddress;
    if (needOppositeAddressBool) {
      walletAddress = _handleAddressTypeWithOpposite(neededAddressType: walletAddressType);
    } else {
      walletAddress = _tryCreateWalletAddress(value);
    }
    walletAddressNotifier.value = walletAddress;

    if (value.isEmpty) {
      formFieldKey.currentState?.reset();
    } else {
      formFieldKey.currentState?.validate();
    }
    widget.onChanged.call(walletAddress);
  }

  AWalletAddress? _handleAddressTypeWithOpposite({required WalletAddressType neededAddressType}) {
    AWalletAddress? correctAddress;
    try {
      switch (neededAddressType) {
        case WalletAddressType.cosmos:
          correctAddress = CosmosWalletAddress.fromAnyType(textEditingController.text);
        case WalletAddressType.ethereum:
          correctAddress = EthereumWalletAddress.fromAnyType(textEditingController.text);
      }
      walletAddressNotifier.value = correctAddress;
      textEditingController.text = correctAddress.address;
      oppositeAddressNotifier.value = correctAddress.toOppositeAddressType().address;
    } catch (_) {
      // NOTE: catches error on force parsing of invalid address, so address type didn't changed, or address is not correct
      walletAddressNotifier.value = null;
      oppositeAddressNotifier.value = null;
    }
    return correctAddress;
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
