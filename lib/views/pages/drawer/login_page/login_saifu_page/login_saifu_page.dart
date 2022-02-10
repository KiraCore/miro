import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/create_wallet_link_button.dart';
import 'package:miro/views/pages/drawer/login_page/login_saifu_page/login_public_key_section.dart';
import 'package:miro/views/pages/drawer/login_page/login_saifu_page/saifu_camera_widget.dart';

class LoginSaifuPage extends StatefulWidget {
  const LoginSaifuPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginSaifuPage();
}

class _LoginSaifuPage extends State<LoginSaifuPage> {
  String? errorMessage;
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Connect a wallet with Saifu', style: Theme.of(context).textTheme.headline1),
        Text('Enter QR code with your Saifu app', style: Theme.of(context).textTheme.headline2),
        const SizedBox(height: 24),
        SaifuCameraWidget(
          width: double.infinity,
          height: 228,
          validate: _validatePublicAddress,
          onReceiveQrCode: _loginIntoAccount,
        ),
        const SizedBox(height: 8),
        LoginPublicKeySection(
          validate: _validatePublicAddress,
          onLoginPressed: _loginIntoAccount,
        ),
        const Spacer(),
        const CreateWalletLinkButton(),
      ],
    );
  }

  void _loginIntoAccount(String publicAddress) {
    bool publicAddressValid = _validatePublicAddress(publicAddress) == null;
    if (publicAddressValid) {
      globalLocator<WalletProvider>().updateWallet(
        SaifuWallet.fromAddress(
          address: WalletAddress.fromBech32(publicAddress),
        ),
      );
      KiraScaffold.of(context).closeEndDrawer();
    }
  }

  String? _validatePublicAddress(String? publicAddress) {
    if (publicAddress == null) {
      String errorMessage = 'Invalid public address';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }
    try {
      WalletAddress.fromBech32(publicAddress);
    } catch (_) {
      String errorMessage = 'Invalid public address';
      AppLogger().log(message: errorMessage, logLevel: LogLevel.warning);
      return errorMessage;
    }
    return null;
  }
}
