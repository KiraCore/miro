import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Tab> tabs;

  const KiraTabBar({
    required this.tabController,
    required this.tabs,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Theme(
      data: ThemeData().copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        textTheme: textTheme,
      ),
      child: Container(
        height: 46,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: DesignColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        // TODO(dominik): remove [IgnorePointer] after implementing transactions
        child: IgnorePointer(
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: DesignColors.grey2,
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 20),
            labelStyle: textTheme.caption!.copyWith(fontWeight: FontWeight.w400),
            labelColor: DesignColors.white1,
            unselectedLabelStyle: textTheme.caption,
            unselectedLabelColor: DesignColors.white2,
            tabs: tabs.map((Tab tab) {
              return Tab(
                height: 30,
                text: tab.text ?? '',
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
