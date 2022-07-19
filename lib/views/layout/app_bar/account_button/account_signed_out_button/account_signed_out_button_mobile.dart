import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/login_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class AccountSignedOutButtonMobile extends StatelessWidget {
  final Size size;

  const AccountSignedOutButtonMobile({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraElevatedButton(
      width: size.width,
      height: size.height,
      onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(const LoginPage()),
      iconData: AppIcons.account,
    );
  }
}
