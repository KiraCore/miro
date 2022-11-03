import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/drawer_wrapper.dart';

class MenuWrapper extends StatelessWidget {
  const MenuWrapper({
    Key? key,
  }) : super(key: key);

  static List<NavItemModel> navItemModelList = <NavItemModel>[
    const NavItemModel(
      pageRouteInfo: DashboardRoute(),
      name: 'Dashboard',
      icon: AppIcons.dashboard,
    ),
    const NavItemModel(
      pageRouteInfo: null,
      disabled: true,
      name: 'Validators',
      icon: AppIcons.shield,
    ),
    const NavItemModel(
      pageRouteInfo: null,
      disabled: true,
      name: 'Transactions',
      icon: AppIcons.transactions,
    ),
    const NavItemModel(
      pageRouteInfo: null,
      disabled: true,
      name: 'Blocks',
      icon: AppIcons.block,
    ),
    const NavItemModel(
      pageRouteInfo: null,
      disabled: true,
      name: 'Governance',
      icon: AppIcons.governance,
    ),
    const NavItemModel(
      pageRouteInfo: null,
      disabled: true,
      name: 'Proposals',
      icon: AppIcons.proposals,
    ),
    const NavItemModel(
      pageRouteInfo: AccountsRoute(),
      name: 'Accounts',
      icon: AppIcons.account,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return KiraScaffold(
      navItemModelList: navItemModelList,
      drawerScrimColor: const Color(0x99000000),
      endDrawer: const DrawerWrapper(),
      body: const AutoRouter(
        key: GlobalObjectKey('pages_router'),
      ),
    );
  }
}
