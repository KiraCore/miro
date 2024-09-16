import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/views/layout/app_bar/app_bar_desktop/kira_app_bar_desktop.dart';
import 'package:miro/views/layout/app_bar/app_bar_mobile/kira_app_bar_mobile.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop.dart';

class KiraScaffoldMobile extends StatelessWidget {
  final Widget child;
  final List<NavItemModel> navItemModelList;

  const KiraScaffoldMobile({
    required this.child,
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      appbarBuilder: ({required bool expandedBool}) {
        return const KiraAppBarDesktop(height: AppSizes.desktopAppbarHeight);
        return KiraAppBarMobile(
          height: 52,
          isExpanded: expandedBool,
          navItemModelList: navItemModelList,
        );
      },
      body: child,
    );
  }
}
