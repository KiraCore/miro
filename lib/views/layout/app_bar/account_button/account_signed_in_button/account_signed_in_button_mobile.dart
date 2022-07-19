import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/account_drawer_page/account_drawer_page.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountSignedInButtonMobile extends StatelessWidget {
  final Wallet wallet;
  final Size size;

  const AccountSignedInButtonMobile({
    required this.wallet,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(const AccountDrawerPage()),
        child: KiraIdentityAvatar(
          size: size.height,
          address: wallet.address.bech32Address,
        ),
      ),
    );
  }
}
