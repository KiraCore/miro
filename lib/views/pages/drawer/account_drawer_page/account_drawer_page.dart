import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_tile.dart';

class AccountDrawerPage extends StatelessWidget {
  const AccountDrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wallet wallet = globalLocator<WalletProvider>().currentWallet!;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          MyAccountTile(wallet: wallet),
          const Divider(color: DesignColors.blue1_20),
          SizedBox(
            height: 500,
            child: AccountMenuList(onItemTap: () => KiraScaffold.of(context).closeEndDrawer()),
          ),
        ],
      ),
    );
  }
}
