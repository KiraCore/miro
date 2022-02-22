import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/current_wallet_button/account_button.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/login_page/login_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:provider/provider.dart';

class CurrentWalletButton extends StatefulWidget {
  final Color popupBackgroundColor;

  const CurrentWalletButton({
    required this.popupBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CurrentWalletButton();
}

class _CurrentWalletButton extends State<CurrentWalletButton> {
  final double _kButtonWidth = 180;

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (_, WalletProvider networkProvider, Widget? child) {
        final Wallet? _wallet = networkProvider.currentWallet;
        if (_wallet != null) {
          return _buildSignedIn(_wallet);
        }
        return _buildSignedOut();
      },
    );
  }

  Widget _buildSignedIn(Wallet wallet) {
    return SizedBox(
      width: _kButtonWidth,
      height: AppSizes.kAppBarItemsHeight,
      child: AccountButton(
        wallet: wallet,
        width: _kButtonWidth,
        popupBackgroundColor: widget.popupBackgroundColor,
        height: AppSizes.kAppBarItemsHeight,
      ),
    );
  }

  Widget _buildSignedOut() {
    return KiraElevatedButton(
      width: _kButtonWidth,
      height: AppSizes.kAppBarItemsHeight,
      onPressed: () {
        KiraScaffold.of(context).navigateEndDrawerRoute(const LoginPage());
      },
      title: 'Connect a Wallet',
    );
  }
}
