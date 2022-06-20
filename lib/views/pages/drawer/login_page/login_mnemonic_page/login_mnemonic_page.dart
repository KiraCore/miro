import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/unsafe_wallet.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/cryptography/bip39_extension.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class LoginMnemonicPage extends StatefulWidget {
  const LoginMnemonicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginMnemonicPage();
}

class _LoginMnemonicPage extends State<LoginMnemonicPage> {
  final EditableMnemonicGridController editableMnemonicGridController =
      EditableMnemonicGridController(mnemonicSize: 24);
  String? errorMessage;
  bool loadingStatus = false;

  @override
  Widget build(BuildContext context) {
    Map<MnemonicValidateResult, String> mnemonicErrors = <MnemonicValidateResult, String>{
      MnemonicValidateResult.invalidChecksum: 'Invalid checksum',
      MnemonicValidateResult.invalidEntropy: 'Invalid entropy',
      MnemonicValidateResult.invalidMnemonic: 'Invalid mnemonic',
      MnemonicValidateResult.mnemonicTooShort: 'Mnemonic too short',
      MnemonicValidateResult.undefinedError: 'Undefined error',
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Connect a wallet with Mnemonic', style: Theme.of(context).textTheme.headline1),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('Write or paste your mnemonic', style: Theme.of(context).textTheme.headline2),
            // TODO(dominik): Add tooltip message
            const KiraToolTip(
              message: 'Some message how to login with mnemonic',
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (loadingStatus)
          const SizedBox(
            width: double.infinity,
            height: 450,
            child: Center(
              child: Text('Connecting into account...'),
            ),
          )
        else
          EditableMnemonicGrid(
            editableMnemonicGridController: editableMnemonicGridController,
            // editable: true,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 15),
          child: Center(
            child: Text(
              errorMessage ?? '',
              style: const TextStyle(
                color: DesignColors.red_100,
              ),
            ),
          ),
        ),
        ValueListenableBuilder<MnemonicValidateResult>(
          valueListenable: editableMnemonicGridController.mnemonicValidateResultNotifier,
          builder: (_, MnemonicValidateResult mnemonicValidateResult, __) {
            Widget button = KiraElevatedButton(
              onPressed: _onLoginButtonPressed,
              disabled: mnemonicValidateResult != MnemonicValidateResult.success,
              title: 'Connect a wallet',
            );
            if (mnemonicValidateResult != MnemonicValidateResult.success) {
              return KiraToolTip(
                message: mnemonicErrors[mnemonicValidateResult]!,
                child: button,
              );
            } else {
              return button;
            }
          },
        ),
      ],
    );
  }

  Future<void> _onLoginButtonPressed() async {
    Mnemonic? mnemonic = editableMnemonicGridController.save();
    if (mnemonic == null) {
      return;
    }
    _setLoadingState(state: true);
    // Complete all UI operations before heavy Wallet deriving
    await Future<void>.delayed(const Duration(milliseconds: 500));

    try {
      UnsafeWallet unsafeWallet = UnsafeWallet.derive(mnemonic: mnemonic);
      globalLocator<WalletProvider>().updateWallet(unsafeWallet);
      KiraScaffold.of(context).closeEndDrawer();
    } catch (e) {
      String errorMessage = 'Something unexpected happened';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.terribleFailure);
      _setLoadingState(state: false);
    }
  }

  void _setLoadingState({required bool state}) {
    setState(() {
      loadingStatus = state;
    });
  }
}
