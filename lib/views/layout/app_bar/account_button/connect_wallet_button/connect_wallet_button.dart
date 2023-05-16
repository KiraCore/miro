import 'package:flutter/cupertino.dart';
import 'package:miro/views/layout/app_bar/account_button/connect_wallet_button/connect_wallet_button_desktop.dart';
import 'package:miro/views/layout/app_bar/account_button/connect_wallet_button/connect_wallet_button_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ConnectWalletButton extends StatelessWidget {
  final Size size;

  const ConnectWalletButton({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget connectWalletButtonDesktop = ConnectWalletButtonDesktop(size: size);
    Widget connectWalletButtonMobile = ConnectWalletButtonMobile(size: size);

    return ResponsiveWidget(
      largeScreen: connectWalletButtonDesktop,
      mediumScreen: connectWalletButtonDesktop,
      smallScreen: connectWalletButtonMobile,
    );
  }
}
