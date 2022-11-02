import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/views/layout/app_bar/mobile_backdrop/backdrop_app_bar.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item.dart';
import 'package:miro/views/layout/nav_menu/model/nav_menu_theme_data.dart';
import 'package:miro/views/layout/nav_menu/nav_tile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class NavMenu extends StatefulWidget {
  final List<NavItem> navItems;
  final NavMenuThemeData? navMenuTheme;
  final Widget logo;

  const NavMenu({
    required this.navItems,
    required this.logo,
    this.navMenuTheme,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavMenu();
}

class _NavMenu extends State<NavMenu> {
  late NavItem currentItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.menuItemWidth,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          if (ResponsiveWidget.isLargeScreen(context))
            SizedBox(
              height: AppSizes.appBarHeight,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.logo,
                  ],
                ),
              ),
            ),
          const SizedBox(height: 40),
          ...widget.navItems.map<Widget>(_buildMenuTile).toList(),
        ],
      ),
    );
  }

  Widget _buildMenuTile(NavItem navItem) {
    return NavTile(
      navItem: navItem,
      navItemTheme: widget.navMenuTheme?.navTileTheme,
      onTap: navItem.isEnabled ? () => _onMenuItemTap(navItem) : null,
    );
  }

  void _onMenuItemTap(NavItem navItem) {
    if (navItem.isEnabled) {
      setState(() {
        currentItem = navItem;
      });
      KiraRouter.of(context).navigate(navItem.pageRouteInfo!);
      _closeBackdrop();
    }
  }

  // Because backdrop exists only on tablet and mobile
  // check if current window doesn't have desktop size
  void _closeBackdrop() {
    if (!ResponsiveWidget.isLargeScreen(context)) {
      try {
        Backdrop.of(context).fling();
      } catch (_) {
        AppLogger().log(message: 'Context not provided', logLevel: LogLevel.terribleFailure);
      }
    }
  }
}
