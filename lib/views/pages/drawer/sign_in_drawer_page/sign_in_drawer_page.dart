import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_drawer_page/create_wallet_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_mnemonic_drawer_page/sign_in_mnemonic_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class SignInDrawerPage extends StatefulWidget {
  const SignInDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInDrawerPage();
}

class _SignInDrawerPage extends State<SignInDrawerPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        DrawerTitle(
          title: S.of(context).connectWallet,
          subtitle: S.of(context).connectWalletOptions,
        ),
        const SizedBox(height: 32),
        KiraElevatedButton(
          title: S.of(context).keyfile,
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const SignInKeyfileDrawerPage());
          },
        ),
        const SizedBox(height: 16),
        KiraElevatedButton(
          title: S.of(context).mnemonic,
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const SignInMnemonicDrawerPage());
          },
        ),
        const SizedBox(height: 32),
        Text(
          S.of(context).createWalletDontHave,
          style: textTheme.bodyMedium!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 16),
        KiraOutlinedButton(
          title: S.of(context).createWalletButton,
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const CreateWalletDrawerPage());
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
