import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page/login_mnemonic_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const DrawerTitle(
          title: 'Connect a wallet',
          subtitle: 'Choose one of the following options:',
        ),
        const SizedBox(height: 32),
        KiraElevatedButton(
          title: 'Keyfile',
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const LoginKeyfilePage());
          },
        ),
        const SizedBox(height: 16),
        KiraElevatedButton(
          title: 'Mnemonic',
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const LoginMnemonicPage());
          },
        ),
        const SizedBox(height: 32),
        Text(
          "Don't have a wallet?",
          style: textTheme.bodyText2!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 16),
        KiraOutlinedButton(
          title: 'Create new wallet',
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const CreateWalletPage());
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
