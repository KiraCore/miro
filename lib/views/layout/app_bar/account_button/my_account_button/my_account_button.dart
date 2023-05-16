import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/my_account_button/my_account_button_desktop.dart';
import 'package:miro/views/layout/app_bar/account_button/my_account_button/my_account_button_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class MyAccountButton extends StatelessWidget {
  final Size size;
  final Wallet wallet;

  const MyAccountButton({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget myAccountButtonDesktop = MyAccountButtonDesktop(wallet: wallet, size: size);
    Widget myAccountButtonMobile = MyAccountButtonMobile(wallet: wallet, size: size);

    return ResponsiveWidget(
      largeScreen: myAccountButtonDesktop,
      mediumScreen: myAccountButtonDesktop,
      smallScreen: myAccountButtonMobile,
    );
  }
}
