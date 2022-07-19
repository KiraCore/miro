import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list/account_menu_list_item.dart';

class AccountMenuList extends StatelessWidget {
  final VoidCallback? onItemTap;

  const AccountMenuList({
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        AccountMenuListItem(
          onTap: () => _onNavigateToMyAccountPressed(context),
          title: const Text('My account'),
        ),
        AccountMenuListItem(
          onTap: () {},
          title: const Text('Settings'),
        ),
        AccountMenuListItem(
          onTap: () => _onLogout(context),
          title: const Text(
            'Log Out',
            style: TextStyle(
              color: DesignColors.red_100,
            ),
          ),
        ),
      ],
    );
  }

  void _onNavigateToMyAccountPressed(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    AutoRouter.of(context).navigate(const MyAccountRoute());
  }

  void _onLogout(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    globalLocator<WalletProvider>().logout(context);
    AutoRouter.of(context).replace(const DashboardRoute());
  }
}
