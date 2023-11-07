import 'package:flutter/material.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/nav_menu/nav_tile.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class NavMenu extends StatefulWidget {
  final List<NavItemModel> navItemModelList;

  const NavMenu({
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavMenu();
}

class _NavMenu extends State<NavMenu> {
  final NavMenuCubit navMenuCubit = globalLocator<NavMenuCubit>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.navItemModelList.length,
      itemBuilder: (BuildContext context, int index) {
        NavItemModel navItemModel = widget.navItemModelList[index];

        return NavTile(
          navItemModel: navItemModel,
          onTap: navItemModel.disabled ? null : () => _handleMenuItemTap(navItemModel),
        );
      },
    );
  }

  void _handleMenuItemTap(NavItemModel navItemModel) {
    if (navItemModel.disabled || navItemModel.pageRouteInfo == null) {
      return;
    }
    KiraRouter.of(context).replace(navItemModel.pageRouteInfo!);
    bool hasBackdrop = ResponsiveWidget.isSmallScreen(context) || ResponsiveWidget.isMediumScreen(context);
    if (hasBackdrop) {
      _closeBackdrop();
    }
  }

  void _closeBackdrop() {
    try {
      Backdrop.of(context).invertVisibility();
    } catch (_) {
      AppLogger().log(message: 'Backdrop doesn`t exists in current context', logLevel: LogLevel.fatal);
    }
  }
}
