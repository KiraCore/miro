import 'package:flutter/cupertino.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/login_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class SignedOutAccountButton extends StatelessWidget {
  final Size size;

  const SignedOutAccountButton({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget signedOutButtonDesktop = _SignedOutButtonDesktop(size: size);
    Widget signedOutButtonMobile = _SignedOutButtonMobile(size: size);

    return ResponsiveWidget(
      largeScreen: signedOutButtonDesktop,
      mediumScreen: signedOutButtonDesktop,
      smallScreen: signedOutButtonMobile,
    );
  }
}

class _SignedOutButtonDesktop extends StatelessWidget {
  final Size size;

  const _SignedOutButtonDesktop({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraElevatedButton(
      width: size.width,
      height: size.height,
      onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(const LoginPage()),
      title: 'Connect a Wallet',
    );
  }
}

class _SignedOutButtonMobile extends StatelessWidget {
  final Size size;

  const _SignedOutButtonMobile({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraElevatedButton(
      width: size.width,
      height: size.height,
      onPressed: () => KiraScaffold.of(context).navigateEndDrawerRoute(const LoginPage()),
      icon: const Icon(AppIcons.account, size: 14),
    );
  }
}
