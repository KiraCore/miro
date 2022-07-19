import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar_mobile.dart';
import 'package:miro/views/layout/app_bar/mobile_backdrop/backdrop_app_bar.dart';

class KiraScaffoldMobile extends StatelessWidget {
  final KiraAppBar appBar;
  final Widget body;
  final Widget navMenu;

  const KiraScaffoldMobile({
    required this.appBar,
    required this.body,
    required this.navMenu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BackdropAppBar(
          appbarBuilder: (bool isCollapsed) {
            return KiraAppBarMobile(
              mobileDecoration: appBar.mobileDecoration,
              isCollapsed: isCollapsed,
              menu: Column(
                children: <Widget>[
                  const SizedBox(height: 25),
                  appBar.sidebar,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: navMenu,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(child: body),
      ],
    );
  }
}
