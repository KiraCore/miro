import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_drawer_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class ConnectWalletButtonMobile extends StatelessWidget {
  final Size size;

  const ConnectWalletButtonMobile({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraElevatedButton(
      width: size.width,
      height: size.height,
      onPressed: () => _handleNavigation(context),
      icon: const Icon(AppIcons.account, color: DesignColors.background, size: 14),
    );
  }

  Future<void> _handleNavigation(BuildContext context) async {
    KiraScaffold.of(context).navigateEndDrawerRoute(const SignInDrawerPage());
    await Future<void>.delayed(const Duration(milliseconds: 500));
    Backdrop.of(context).collapse();
  }
}
