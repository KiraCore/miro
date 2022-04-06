import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar_desktop.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_desktop_decoration.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_mobile_decoration.dart';

class KiraAppBar extends StatelessWidget {
  final AppBarDesktopDecoration desktopDecoration;
  final AppBarMobileDecoration mobileDecoration;
  final Widget sidebar;

  const KiraAppBar({
    required this.desktopDecoration,
    required this.mobileDecoration,
    required this.sidebar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraAppBarDesktop(
      sidebar: sidebar,
      desktopDecoration: desktopDecoration,
    );
  }
}
