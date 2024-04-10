import 'package:cryptography_utils/cryptography_utils.dart' as crypto_utils;
import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/cryptography/bip39/mnemonic_validation_result.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/create_wallet_link_button.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_grid.dart';

class SignInMnemonicDrawerPage extends StatefulWidget {
  const SignInMnemonicDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInMnemonicDrawerPage();
}

class _SignInMnemonicDrawerPage extends State<SignInMnemonicDrawerPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final MnemonicGridCubit mnemonicGridCubit = MnemonicGridCubit();
  bool loadingStatusBool = false;

  @override
  void initState() {
    super.initState();
    mnemonicGridCubit.init(initialMnemonicGridSize: 24);
  }

  @override
  void dispose() {
    mnemonicGridCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Map<MnemonicValidationResult, String> mnemonicErrors = <MnemonicValidationResult, String>{
      MnemonicValidationResult.invalidChecksum: S.of(context).mnemonicErrorInvalidChecksum,
      MnemonicValidationResult.invalidMnemonic: S.of(context).mnemonicErrorInvalid,
      MnemonicValidationResult.mnemonicTooShort: S.of(context).mnemonicErrorTooShort,
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: S.of(context).mnemonicSignIn,
          subtitle: S.of(context).mnemonicEnter,
          tooltipMessage: S.of(context).mnemonicLoginHint,
        ),
        const SizedBox(height: 24),
        if (loadingStatusBool)
          SizedBox(
            width: double.infinity,
            height: 450,
            child: Center(
              child: Text(S.of(context).connectWalletConnecting),
            ),
          )
        else
          MnemonicGrid(mnemonicGridCubit: mnemonicGridCubit),
        const SizedBox(height: 24),
        ValueListenableBuilder<MnemonicValidationResult>(
          valueListenable: mnemonicGridCubit.mnemonicValidationResultNotifier,
          builder: (_, MnemonicValidationResult mnemonicValidationResult, __) {
            bool mnemonicValidBool = mnemonicValidationResult != MnemonicValidationResult.success;
            bool mnemonicCompleteBool = mnemonicValidationResult != MnemonicValidationResult.mnemonicTooShort;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                KiraElevatedButton(
                  onPressed: _pressSignInButton,
                  disabled: mnemonicValidationResult != MnemonicValidationResult.success,
                  title: S.of(context).connectWalletButtonSignIn,
                ),
                const SizedBox(height: 8),
                if (mnemonicValidBool && mnemonicCompleteBool)
                  Text(
                    mnemonicErrors[mnemonicValidationResult]!,
                    style: textTheme.bodySmall!.copyWith(
                      color: DesignColors.redStatus1,
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 32),
        const CreateWalletLinkButton(),
        const SizedBox(height: 32),
      ],
    );
  }

  Future<void> _pressSignInButton() async {
    _setLoadingStatus(loadingStatusBool: true);
    Wallet? wallet = await _generateWallet();
    if (wallet == null) {
      _setLoadingStatus(loadingStatusBool: false);
      return;
    } else {
      await authCubit.signIn(wallet);
      KiraScaffold.of(context).closeEndDrawer();
    }
  }

  // WARNING: This method is very heavy and can freeze the UI
  // TODO(dominik): Move to web workers / separate thread when available
  Future<Wallet?> _generateWallet() async {
    // Mnemonic? mnemonic = mnemonicGridCubit.buildMnemonicObject();
    crypto_utils.Mnemonic? mnemonic = mnemonicGridCubit.buildMnemonicObject();
    if (mnemonic == null) {
      return null;
    }
    // Complete all UI operations before heavy Wallet deriving
    await Future<void>.delayed(const Duration(milliseconds: 500));
    try {
      // return Wallet.derive(mnemonic: mnemonic);
      crypto_utils.LegacyHDWallet legacyHDWallet = await crypto_utils.LegacyHDWallet.fromMnemonic(
        mnemonic: mnemonic,
        walletConfig: crypto_utils.Bip44WalletsConfig.kira,
        derivationPathString: "m/44'/118'/0'/0/0",
      );
      return Wallet.fromLegacyHDWallet(legacyHDWallet);
    } catch (e) {
      AppLogger().log(message: 'Cannot generate wallet', logLevel: LogLevel.fatal);
      return null;
    }
  }

  void _setLoadingStatus({required bool loadingStatusBool}) {
    if (mounted) {
      setState(() => this.loadingStatusBool = loadingStatusBool);
    }
  }
}
