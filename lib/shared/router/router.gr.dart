// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../views/pages/loading/connections_page/connections_page.dart' as _i4;
import '../../views/pages/loading/loading_page/loading_page.dart' as _i3;
import '../../views/pages/loading/loading_wrapper.dart' as _i1;
import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i5;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i6;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i8;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i7;
import '../../views/pages/pages_wrapper.dart' as _i2;
import '../guards/auth_guard.dart' as _i14;
import '../guards/connection_guard.dart' as _i11;
import '../guards/navigation_guard.dart' as _i13;
import '../guards/url_parameters_guard.dart' as _i12;

class AppRouter extends _i9.RootStackRouter {
  AppRouter(
      {_i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
      required this.connectionGuard,
      required this.urlParametersGuard,
      required this.navigationGuard,
      required this.authGuard})
      : super(navigatorKey);

  final _i11.ConnectionGuard connectionGuard;

  final _i12.UrlParametersGuard urlParametersGuard;

  final _i13.NavigationGuard navigationGuard;

  final _i14.AuthGuard authGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoadingWrapperRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i1.LoadingWrapper(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    PagesRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i2.PagesWrapper(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 1000,
          opaque: true,
          barrierDismissible: false);
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(orElse: () => const LoadingRouteArgs());
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: _i3.LoadingPage(nextRoute: args.nextRoute, key: args.key),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ConnectionsRoute.name: (routeData) {
      final args = routeData.argsAs<ConnectionsRouteArgs>(orElse: () => const ConnectionsRouteArgs());
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: _i4.ConnectionsPage(nextRoute: args.nextRoute, key: args.key),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i5.AccountsPage(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i6.DashboardPage(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i7.ValidatorsPage(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyAccountRoute.name: (routeData) {
      return _i9.CustomPage<void>(
          routeData: routeData,
          child: const _i8.MyAccountPage(),
          transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(LoadingWrapperRoute.name, path: '/connection', children: [
          _i9.RouteConfig(LoadingRoute.name, path: 'loading', parent: LoadingWrapperRoute.name),
          _i9.RouteConfig(ConnectionsRoute.name, path: 'select', parent: LoadingWrapperRoute.name)
        ]),
        _i9.RouteConfig(PagesRoute.name, path: '/', guards: [
          connectionGuard
        ], children: [
          _i9.RouteConfig(AccountsRoute.name,
              path: 'accounts', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i9.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i9.RouteConfig(ValidatorsRoute.name,
              path: 'validators', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i9.RouteConfig(MyAccountRoute.name,
              path: 'my-account', parent: PagesRoute.name, guards: [authGuard, urlParametersGuard, navigationGuard]),
          _i9.RouteConfig('#redirect', path: '', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i9.RouteConfig('#redirect', path: '', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.LoadingWrapper]
class LoadingWrapperRoute extends _i9.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/connection', initialChildren: children);

  static const String name = 'LoadingWrapperRoute';
}

/// generated route for [_i2.PagesWrapper]
class PagesRoute extends _i9.PageRouteInfo<void> {
  const PagesRoute({List<_i9.PageRouteInfo>? children}) : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i3.LoadingPage]
class LoadingRoute extends _i9.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({_i9.RouteMatch<dynamic>? nextRoute, _i10.Key? key})
      : super(name, path: 'loading', args: LoadingRouteArgs(nextRoute: nextRoute, key: key));

  static const String name = 'LoadingRoute';
}

class LoadingRouteArgs {
  const LoadingRouteArgs({this.nextRoute, this.key});

  final _i9.RouteMatch<dynamic>? nextRoute;

  final _i10.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextRoute: $nextRoute, key: $key}';
  }
}

/// generated route for [_i4.ConnectionsPage]
class ConnectionsRoute extends _i9.PageRouteInfo<ConnectionsRouteArgs> {
  ConnectionsRoute({_i9.RouteMatch<dynamic>? nextRoute, _i10.Key? key})
      : super(name, path: 'select', args: ConnectionsRouteArgs(nextRoute: nextRoute, key: key));

  static const String name = 'ConnectionsRoute';
}

class ConnectionsRouteArgs {
  const ConnectionsRouteArgs({this.nextRoute, this.key});

  final _i9.RouteMatch<dynamic>? nextRoute;

  final _i10.Key? key;

  @override
  String toString() {
    return 'ConnectionsRouteArgs{nextRoute: $nextRoute, key: $key}';
  }
}

/// generated route for [_i5.AccountsPage]
class AccountsRoute extends _i9.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i6.DashboardPage]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i7.ValidatorsPage]
class ValidatorsRoute extends _i9.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i8.MyAccountPage]
class MyAccountRoute extends _i9.PageRouteInfo<void> {
  const MyAccountRoute() : super(name, path: 'my-account');

  static const String name = 'MyAccountRoute';
}
