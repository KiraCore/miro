import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/current_network_button.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/layout/report_issues_button.dart';

class KiraAppBarMobileExpansion extends StatelessWidget {
  final List<NavItemModel> navItemModelList;

  const KiraAppBarMobileExpansion({
    required this.navItemModelList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            CurrentNetworkButton(size: const Size(double.infinity, 48)),
            const SizedBox(height: 30),
            NavMenu(navItemModelList: navItemModelList),
            const SizedBox(height: 30),
            const ReportIssuesButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
