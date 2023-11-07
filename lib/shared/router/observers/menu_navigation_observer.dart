import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_cubit.dart';
import 'package:miro/config/locator.dart';

class MenuNavigationObserver extends AutoRouterObserver {
  final NavMenuCubit navMenuCubit = globalLocator<NavMenuCubit>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    navMenuCubit.updateRouteName(route.settings.name ?? '');
  }
}
