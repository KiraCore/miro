import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class ConnectWalletButtonDesktop extends StatelessWidget {
  final Size size;

  const ConnectWalletButtonDesktop({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraElevatedButton(
      width: size.width,
      height: size.height,
      onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(const SignInDrawerPage()),
      title: S.of(context).connectWallet,
    );
  }
}
