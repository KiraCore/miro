import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/app_bar/app_bar_mobile/kira_app_bar_mobile_expansion.dart';
import 'package:miro/views/layout/app_bar/app_bar_mobile/kira_app_bar_mobile_header.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';

class KiraAppBarMobile extends StatefulWidget {
  final double height;
  final bool isExpanded;
  final List<NavItemModel> navItemModelList;

  const KiraAppBarMobile({
    required this.height,
    required this.isExpanded,
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraAppBarMobile();
}

class _KiraAppBarMobile extends State<KiraAppBarMobile> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: widget.isExpanded ? 6 : 2),
      child: Container(
        decoration: BoxDecoration(
          color: DesignColors.blue1_10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: KiraAppBarMobileHeader(height: widget.height),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: SizedBox(
                width: double.infinity,
                height: widget.isExpanded ? MediaQuery.of(context).size.height - AppSizes.mobileAppbarHeight : 0,
                child: KiraAppBarMobileExpansion(navItemModelList: widget.navItemModelList),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
