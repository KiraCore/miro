import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/create_wallet_drawer_page/create_wallet_drawer_page.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class CreateWalletLinkButton extends StatelessWidget {
  const CreateWalletLinkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 32),
        Text(
          S.of(context).createWalletDontHave,
          style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
        ),
        const SizedBox(height: 8),
        TextLink(
          text: S.of(context).createWalletButton,
          textStyle: textTheme.bodyText2!,
          onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(const CreateWalletDrawerPage()),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
