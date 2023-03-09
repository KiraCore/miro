import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/app_bar/app_bar_desktop/kira_app_bar_desktop.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/sidebar/sidebar_desktop.dart';

class KiraScaffoldDesktop extends StatelessWidget {
  final Widget child;
  final List<NavItemModel> navItemModelList;

  const KiraScaffoldDesktop({
    required this.child,
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SidebarDesktop(navItemModelList: navItemModelList),
        Expanded(
          child: Column(
            children: <Widget>[
              const KiraAppBarDesktop(height: AppSizes.desktopAppbarHeight),
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: DesignColors.grey3),
                        left: BorderSide(color: DesignColors.grey3),
                      ),
                    ),
                    child: child),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
