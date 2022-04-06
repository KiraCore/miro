import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/app_bar/account_button/current_account_button.dart';
import 'package:miro/views/layout/app_bar/current_network_button.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar.dart';
import 'package:miro/views/layout/app_bar/mobile_backdrop/backdrop_toggle_button.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_desktop_decoration.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_mobile_decoration.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item.dart';
import 'package:miro/views/layout/nav_menu/model/nav_menu_theme_data.dart';
import 'package:miro/views/layout/nav_menu/model/nav_tile_theme_data.dart';
import 'package:miro/views/layout/nav_menu/model/tile_decoration.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/drawer_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';
import 'package:miro/views/widgets/generic/responsive/sized_box_expanded.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';
import 'package:miro/views/widgets/kira/kira_logo.dart';

class PagesWrapper extends StatelessWidget {
  const PagesWrapper({
    Key? key,
  }) : super(key: key);

  static List<NavItem> visibleNavItems = <NavItem>[
    const NavItem(
      pageRouteInfo: DashboardRoute(),
      name: 'Dashboard',
      icon: AppIcons.dashboard,
    ),
    const NavItem(
      pageRouteInfo: null,
      name: 'Validators',
      icon: AppIcons.validator,
    ),
    const NavItem(
      pageRouteInfo: null,
      name: 'Transactions',
      icon: AppIcons.transaction,
    ),
    const NavItem(
      pageRouteInfo: null,
      name: 'Blocks',
      icon: AppIcons.block,
    ),
    const NavItem(
      pageRouteInfo: null,
      name: 'Governance',
      icon: AppIcons.governance,
    ),
    const NavItem(
      pageRouteInfo: null,
      name: 'Proposals',
      icon: AppIcons.proposals,
    ),
    const NavItem(
      pageRouteInfo: AccountsRoute(),
      name: 'Accounts',
      icon: AppIcons.account,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return KiraScaffold(
      appBar: _buildAppBar(context),
      navMenu: _buildMenu(context),
      drawerScrimColor: const Color(0x99000000),
      endDrawer: const DrawerWrapper(),
      body: const AutoRouter(
        key: GlobalObjectKey('pages_router'),
        // navigatorObservers: () => <AutoRouterObserver>[
        //   CoreNavigatorObserver(context),
        // ],
      ),
    );
  }

  KiraAppBar _buildAppBar(BuildContext context) {
    return KiraAppBar(
      sidebar: _buildSidebarContent(context),
      mobileDecoration: AppBarMobileDecoration(
        title: const KiraLogo(height: 30),
        leading: const BackdropToggleButton(),
        trailing: const CurrentAccountButton(),
        backdropColor: DesignColors.blue1_10,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      desktopDecoration: AppBarDesktopDecoration(
        backgroundColor: DesignColors.blue1_10,
      ),
    );
  }

  NavMenu _buildMenu(BuildContext context) {
    return NavMenu(
      logo: const KiraLogo(height: 30),
      navItems: visibleNavItems,
      navMenuTheme: NavMenuThemeData(
        navTileTheme: NavTileThemeData(
          enabledTileDecoration: TileDecoration(
            backgroundColor: Colors.transparent,
            fontColor: DesignColors.gray2_100,
          ),
          enabledHoverTileDecoration: TileDecoration(
            backgroundColor: DesignColors.blue1_20,
            fontColor: DesignColors.blue1_100,
          ),
          activeTileDecoration: TileDecoration(
            backgroundColor: DesignColors.blue1_10,
            fontColor: DesignColors.blue1_100,
          ),
          disabledTileDecoration: TileDecoration(
            fontColor: DesignColors.gray2_40,
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarContent(BuildContext context) {
    return ColumnRowSwapper(
      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      columnCrossAxisAlignment: CrossAxisAlignment.start,
      columnMainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SearchBar(
          label: 'Search for anything',
          width: ResponsiveWidget.isLargeScreen(context) ? 342 : double.infinity,
          height: AppSizes.kAppBarItemsHeight,
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            if (ResponsiveWidget.isLargeScreen(context)) const SizedBox(width: 12),
            const SizedBoxExpanded(
              width: 192,
              expandOn: <ScreenSize>[ScreenSize.mobile, ScreenSize.tablet],
              child: CurrentNetworkButton(),
            ),
            if (ResponsiveWidget.isLargeScreen(context)) ...const <Widget>[
              SizedBox(width: 12),
              CurrentAccountButton(),
            ],
          ],
        ),
      ],
    );
  }
}
