import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/metamask/metamask_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list_tile.dart';

class AccountMenuList extends StatelessWidget {
  final AuthCubit _authCubit = globalLocator<AuthCubit>();
  final MetamaskCubit _metamaskCubit = globalLocator<MetamaskCubit>();
  final VoidCallback? onItemTap;

  AccountMenuList({
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AccountMenuListTile(
          onTap: () => _onNavigateToMyAccountPressed(context),
          title: S.of(context).myAccount,
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
    _authCubit.signOut();
    _metamaskCubit.resetState();
  }
}
