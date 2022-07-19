import 'package:flutter/cupertino.dart';
import 'package:miro/views/layout/app_bar/account_button/account_signed_out_button/account_signed_out_button_desktop.dart';
import 'package:miro/views/layout/app_bar/account_button/account_signed_out_button/account_signed_out_button_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class AccountSignedOutButton extends StatelessWidget {
  final Size desktopSize;
  final Size mobileSize;

  const AccountSignedOutButton({
    required this.desktopSize,
    required this.mobileSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: AccountSignedOutButtonDesktop(size: desktopSize),
      mediumScreen: AccountSignedOutButtonMobile(size: mobileSize),
    );
  }
}
