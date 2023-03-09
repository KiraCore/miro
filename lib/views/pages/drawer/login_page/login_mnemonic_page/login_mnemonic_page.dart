import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/cryptography/bip39_extension.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/create_wallet_link_button.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/mnemonic_grid.dart';
import 'package:miro/views/widgets/kira/mnemonic_grid/model/mnemonic_grid_controller.dart';

class LoginMnemonicPage extends StatefulWidget {
  const LoginMnemonicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginMnemonicPage();
}

class _LoginMnemonicPage extends State<LoginMnemonicPage> {
  final MnemonicGridController mnemonicGridController = MnemonicGridController();
  String? errorMessage;
  bool loadingStatus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const DrawerTitle(
          title: 'Sign in with Mnemonic',
          subtitle: 'Enter your Mnemonic',
          tooltipMessage: 'Mnemonic is your secret data',
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 450,
          child: loadingStatus
              ? const Center(
                  child: Text('Connecting into account...'),
                )
              : MnemonicGrid(
                  controller: mnemonicGridController,
                  editable: true,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 15),
          child: Center(
            child: Text(
              errorMessage ?? '',
              style: const TextStyle(
                color: DesignColors.redStatus1,
              ),
            ),
          ),
        ),
        KiraElevatedButton(
          onPressed: _onLoginButtonPressed,
          title: 'Sign in',
        ),
        const SizedBox(height: 32),
        const CreateWalletLinkButton(),
        const SizedBox(height: 32),
      ],
    );
  }

  Future<void> _onLoginButtonPressed() async {
    _setErrorMessage(null);
    List<String> mnemonicArray = mnemonicGridController.getValues();
    String? mnemonicErrorMessage = _validateMnemonic(mnemonicArray);
    if (mnemonicErrorMessage != null) {
      _setErrorMessage(mnemonicErrorMessage);
      return;
    }
    _setLoadingState(state: true);
    // Complete all UI operations before heavy Wallet deriving
    await Future<void>.delayed(const Duration(milliseconds: 500));

    try {
      Mnemonic mnemonic = Mnemonic.fromArray(array: mnemonicArray);
      Wallet wallet = Wallet.derive(mnemonic: mnemonic);
      globalLocator<WalletProvider>().updateWallet(wallet);
      KiraScaffold.of(context).closeEndDrawer();
    } catch (e) {
      String errorMessage = 'Something unexpected happened';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.terribleFailure);
      _setErrorMessage(errorMessage);
      _setLoadingState(state: false);
    }
  }

  void _setErrorMessage(String? message) {
    setState(() {
      errorMessage = message;
    });
  }

  String? _validateMnemonic(List<String> mnemonicArray) {
    if (mnemonicArray.isEmpty) {
      String errorMessage = 'You have to enter correct Mnemonic to sign in';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }

    MnemonicValidateResult validateResult = Bip39Extension.validateMnemonicWithMessage(mnemonicArray.join(' '));
    if (validateResult == MnemonicValidateResult.success) {
      return null;
    } else {
      String errorMessage = Bip39Extension.statusToMessage(validateResult);
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }
  }

  void _setLoadingState({required bool state}) {
    setState(() {
      loadingStatus = state;
    });
  }
}
