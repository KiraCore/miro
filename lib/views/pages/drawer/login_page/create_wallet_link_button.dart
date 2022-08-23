import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class CreateWalletLinkButton extends StatelessWidget {
  const CreateWalletLinkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(color: Color(0xff343261)),
        const SizedBox(height: 32),
        const Text(
          'Don`t have a wallet?',
          style: TextStyle(
            fontSize: 12,
            color: DesignColors.gray3_100,
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(height: 8),
        TextLink(
          text: 'Create a wallet',
          textStyle: const TextStyle(
            fontSize: 12,
            letterSpacing: 0.1,
          ),
          onTap: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(const CreateWalletPage());
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
