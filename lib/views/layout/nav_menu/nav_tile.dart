import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/menu_provider.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item.dart';
import 'package:miro/views/layout/nav_menu/model/nav_tile_theme_data.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class NavTile extends StatefulWidget {
  final NavItem navItem;
  final NavTileThemeData? navItemTheme;
  final GestureTapCallback? onTap;

  const NavTile({
    required this.navItem,
    this.onTap,
    this.navItemTheme,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavTile();
}

class _NavTile extends State<NavTile> {
  final MenuProvider menuProvider = globalLocator<MenuProvider>();

  @override
  void initState() {
    super.initState();
    menuProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: MouseStateListener(
        onTap: widget.onTap,
        selected: menuProvider.currentPath == widget.navItem.pageRouteInfo?.path,
        disabled: !widget.navItem.isEnabled,
        childBuilder: (Set<MaterialState> states) {
          return Container(
            width: double.infinity,
            height: AppSizes.kKiraScaffoldMenuItemHeight,
            decoration: BoxDecoration(
              color: widget.navItemTheme?.getBackgroundColor(states),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Icon(
                    widget.navItem.icon,
                    size: 15,
                    color: widget.navItemTheme?.getIconColor(states),
                  ),
                  const SizedBox(width: 33),
                  Text(
                    widget.navItem.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: widget.navItemTheme?.getFontColor(states),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
