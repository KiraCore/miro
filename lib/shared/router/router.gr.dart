// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i2;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i3;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i6;
import '../../views/pages/menu/network_visualizer_page/network_visualiser_page.dart' as _i5;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i4;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../guards/auth_guard.dart' as _i11;
import '../guards/navigation_guard.dart' as _i10;
import '../guards/url_parameters_guard.dart' as _i9;

class AppRouter extends _i7.RootStackRouter {
  AppRouter(
      {_i8.GlobalKey<_i8.NavigatorState>? navigatorKey,
      required this.urlParametersGuard,
      required this.navigationGuard,
      required this.authGuard})
      : super(navigatorKey);

  final _i9.UrlParametersGuard urlParametersGuard;

  final _i10.NavigationGuard navigationGuard;

  final _i11.AuthGuard authGuard;

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData, child: const _i1.PagesWrapper(), opaque: true, barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData,
          child: const _i2.AccountsPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData,
          child: const _i3.DashboardPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData,
          child: const _i4.ValidatorsPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    NetworkVisualiserRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData,
          child: const _i5.NetworkVisualiserPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyAccountRoute.name: (routeData) {
      return _i7.CustomPage<void>(
          routeData: routeData,
          child: const _i6.MyAccountPage(),
          transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(PagesRoute.name, path: '/', guards: [
          urlParametersGuard
        ], children: [
          _i7.RouteConfig(AccountsRoute.name,
              path: 'accounts', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i7.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i7.RouteConfig(ValidatorsRoute.name,
              path: 'validators', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i7.RouteConfig(NetworkVisualiserRoute.name,
              path: 'network-visualiser', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i7.RouteConfig(MyAccountRoute.name,
              path: 'my-account', parent: PagesRoute.name, guards: [authGuard, urlParametersGuard, navigationGuard]),
          _i7.RouteConfig('#redirect', path: '', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i7.RouteConfig('#redirect', path: '', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.PagesWrapper]
class PagesRoute extends _i7.PageRouteInfo<void> {
  const PagesRoute({List<_i7.PageRouteInfo>? children}) : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i2.AccountsPage]
class AccountsRoute extends _i7.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i3.DashboardPage]
class DashboardRoute extends _i7.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i4.ValidatorsPage]
class ValidatorsRoute extends _i7.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i5.NetworkVisualiserPage]
class NetworkVisualiserRoute extends _i7.PageRouteInfo<void> {
  const NetworkVisualiserRoute() : super(name, path: 'network-visualiser');

  static const String name = 'NetworkVisualiserRoute';
}

/// generated route for [_i6.MyAccountPage]
class MyAccountRoute extends _i7.PageRouteInfo<void> {
  const MyAccountRoute() : super(name, path: 'my-account');

  static const String name = 'MyAccountRoute';
}
