// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i2;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i3;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i4;
import '../../views/pages/pages_wrapper.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i5.CustomPage<void>(
          routeData: routeData, child: const _i1.PagesWrapper(), opaque: true, barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i5.CustomPage<void>(
          routeData: routeData, child: const _i2.AccountsPage(), opaque: true, barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i5.CustomPage<void>(
          routeData: routeData, child: const _i3.DashboardPage(), opaque: true, barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i5.CustomPage<void>(
          routeData: routeData, child: const _i4.ValidatorsPage(), opaque: true, barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(PagesRoute.name, path: '/', children: [
          _i5.RouteConfig(AccountsRoute.name, path: 'accounts', parent: PagesRoute.name),
          _i5.RouteConfig(DashboardRoute.name, path: 'dashboard', parent: PagesRoute.name),
          _i5.RouteConfig(ValidatorsRoute.name, path: 'validators', parent: PagesRoute.name),
          _i5.RouteConfig('#redirect', path: '', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i5.RouteConfig('#redirect', path: '', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.PagesWrapper]
class PagesRoute extends _i5.PageRouteInfo<void> {
  const PagesRoute({List<_i5.PageRouteInfo>? children}) : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i2.AccountsPage]
class AccountsRoute extends _i5.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i3.DashboardPage]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i4.ValidatorsPage]
class ValidatorsRoute extends _i5.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}
