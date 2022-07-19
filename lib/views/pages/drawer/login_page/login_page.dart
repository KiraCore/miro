import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/create_wallet_link_button.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page/login_mnemonic_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_saifu_page/login_saifu_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/buttons/store_bagde/store_badge.dart';
import 'package:miro/views/widgets/buttons/store_bagde/store_type.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

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
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('Recommended and safe option', style: Theme.of(context).textTheme.headline2),
            // TODO(dominik): Add tooltip message
            const KiraToolTip(
              message: 'Some message why Login with Saifu is the safest option',
            ),
          ],
        ),
        const SizedBox(height: 28),
        KiraElevatedButton(
          title: 'Saifu',
          onPressed: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const LoginSaifuPage());
          },
        ),
        const SizedBox(height: 13),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            StoreBadge(storeType: StoreType.apple),
            StoreBadge(storeType: StoreType.google),
          ],
        ),
        const SizedBox(height: 41),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Or use another options to connect a wallet.',
                    style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14),
                  ),
                  Text(
                    'Note: this is not a safe option to sign in',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 14,
                          color: DesignColors.yellow_100,
                        ),
                  ),
                ],
              ),
            ),
            // TODO(dominik): Add tooltip message
            const KiraToolTip(
              childMargin: EdgeInsets.zero,
              message: 'Some message why Login with Saifu is the safest option',
            ),
          ],
        ),
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
