import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/widgets/kira/kira_logo.dart';

class SidebarDesktop extends StatelessWidget {
  final List<NavItemModel> navItemModelList;

  const SidebarDesktop({
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarDesktopWidth,
      height: double.infinity,
      color: DesignColors.blue1_10,
      padding: const EdgeInsets.only(left: 20, right: 26, top: 26, bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 64),
            child: KiraLogo(height: 30),
          ),
          NavMenu(navItemModelList: navItemModelList),
        ],
      ),
    );
  }
}
