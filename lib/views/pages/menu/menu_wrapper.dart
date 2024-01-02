import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/router/router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/drawer_wrapper.dart';

@RoutePage(name: 'MenuWrapperRoute')
class MenuWrapper extends StatelessWidget {
  const MenuWrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraScaffold(
      navItemModelList: <NavItemModel>[
        NavItemModel(
          pageRouteInfo: const DashboardRoute(),
          name: S.of(context).dashboard,
          icon: AppIcons.dashboard,
        ),
        NavItemModel(
          pageRouteInfo: const ValidatorsRoute(),
          name: S.of(context).validators,
          icon: AppIcons.shield,
        ),
        NavItemModel(
          pageRouteInfo: null,
          disabled: true,
          name: S.of(context).tx,
          icon: AppIcons.transactions,
        ),
        NavItemModel(
          pageRouteInfo: const BlocksRoute(),
          name: S.of(context).blocks,
          icon: AppIcons.block,
        ),
        NavItemModel(
          pageRouteInfo: null,
          disabled: true,
          name: S.of(context).governance,
          icon: AppIcons.governance,
        ),
        NavItemModel(
          pageRouteInfo: null,
          disabled: true,
          name: S.of(context).proposals,
          icon: AppIcons.proposals,
        ),
        NavItemModel(
          pageRouteInfo: null,
          disabled: true,
          name: S.of(context).accounts,
          icon: AppIcons.account,
        ),
      ],
      drawerScrimColor: DesignColors.greyTransparent,
      endDrawer: const DrawerWrapper(),
      body: AutoRouter(
        key: const GlobalObjectKey('menu_router'),
        navigatorObservers: () => <NavigatorObserver>[AppRouter.menuNavigationObserver],
      ),
    );
  }
}
