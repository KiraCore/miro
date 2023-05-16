import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list_tile.dart';

class AccountMenuList extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
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

  void _onNavigateToMyAccountPressed(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    KiraRouter.of(context).navigate(const MyAccountRoute());
  }

  void _pressSignOutButton(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    authCubit.signOut();
    KiraRouter.of(context).navigate(const DashboardRoute());
  }
}
