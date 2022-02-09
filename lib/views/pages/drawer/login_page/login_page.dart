import 'package:flutter/material.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/create_wallet_link_button.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page/login_mnemonic_page.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Connect a Wallet to Kira', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 32),
        KiraOutlinedButton(
          title: 'Key file',
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const LoginKeyfilePage());
          },
        ),
        const SizedBox(height: 20),
        KiraOutlinedButton(
            title: 'Mnemonic or Seed',
            onPressed: () {
              KiraScaffold.of(context).navigateEndDrawerRoute(const LoginMnemonicPage());
            }),
        const Spacer(),
        const CreateWalletLinkButton(),
      ],
    );
  }
}
