import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_signed_in_button/account_signed_in_button_desktop.dart';
import 'package:miro/views/layout/app_bar/account_button/account_signed_in_button/account_signed_in_button_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class AccountSignedInButton extends StatelessWidget {
  final Wallet wallet;
  final Size desktopSize;
  final Size mobileSize;

  const AccountSignedInButton({
    required this.wallet,
    required this.desktopSize,
    required this.mobileSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: AccountSignedInButtonDesktop(
        wallet: wallet,
        size: desktopSize,
      ),
      mediumScreen: AccountSignedInButtonMobile(
        wallet: wallet,
        size: mobileSize,
      ),
    );
  }
}
