import 'package:flutter/cupertino.dart';
import 'package:miro/views/layout/app_bar/account_button/connect_wallet_button/connect_wallet_button_desktop.dart';
import 'package:miro/views/layout/app_bar/account_button/connect_wallet_button/connect_wallet_button_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ConnectWalletButton extends StatelessWidget {
  const ConnectWalletButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget connectWalletButtonDesktop = const ConnectWalletButtonDesktop(size: Size(180, 48));
    Widget connectWalletButtonMobile = const ConnectWalletButtonMobile(size: Size(40, 40));

    return ResponsiveWidget(
      largeScreen: connectWalletButtonDesktop,
      mediumScreen: connectWalletButtonDesktop,
      smallScreen: connectWalletButtonMobile,
    );
  }
}
