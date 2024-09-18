import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/metamask/metamask_integration_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list_tile.dart';
import 'package:provider/provider.dart';

class AccountMenuList extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final VoidCallback? onItemTap;

  AccountMenuList({
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MetaMaskProvider>(
      builder: (BuildContext context, MetaMaskProvider provider, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AccountMenuListTile(
              onTap: () => _onNavigateToMyAccountPressed(context),
              title: S.of(context).myAccount,
            ),
            if (context.read<MetaMaskProvider>().isEnabled)
              AccountMenuListTile(
                onTap: () => _toggleMetamask(
                  context,
                  isConnected: context.read<MetaMaskProvider>().isConnected,
                ),
                title: context.read<MetaMaskProvider>().isConnected ? 'Disconnect Metamask' : 'Connect Metamask',
              ),
            AccountMenuListTile(
              onTap: null,
              title: S.of(context).myAccountSettings,
            ),
            AccountMenuListTile(
              onTap: () => _pressSignOutButton(context),
              title: S.of(context).myAccountSignOut,
              color: DesignColors.redStatus1,
            ),
          ],
        );
      },
    );
  }

  Future<void> _onNavigateToMyAccountPressed(BuildContext context) async {
    if (onItemTap != null) {
      onItemTap!();
    }
    await KiraRouter.of(context).replace(const MyAccountRoute());
  }

  void _pressSignOutButton(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    authCubit.signOut();
  }

  void _toggleMetamask(BuildContext context, {required bool isConnected}) {
    // NOTE: do not close the popup, so user will see the connection status
    if (isConnected) {
      context.read<MetaMaskProvider>().clear();
    } else {
      context.read<MetaMaskProvider>().connect();
    }
  }
}
