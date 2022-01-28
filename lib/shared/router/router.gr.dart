// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../views/pages/drawer/connection_drawer_page/connection_drawer_page.dart'
    as _i5;
import '../../views/pages/drawer/create_wallet_page/create_wallet_page.dart'
    as _i4;
import '../../views/pages/drawer/login_page/login_keyfile_page.dart' as _i6;
import '../../views/pages/drawer/login_page/login_mnemonic_page.dart' as _i7;
import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i2;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i3;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i8;
import '../../views/pages/menu/welcome_page/welcome_page.dart' as _i9;
import '../../views/pages/pages_wrapper.dart' as _i1;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i1.PagesWrapper(),
          opaque: true,
          barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i2.AccountsPage(),
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i3.DashboardPage(),
          opaque: true,
          barrierDismissible: false);
    },
    CreateWalletRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i4.CreateWalletPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ConnectionRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i5.ConnectionDrawerPage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginKeyfileRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i6.LoginKeyfilePage(),
          opaque: true,
          barrierDismissible: false);
    },
    LoginMnemonicRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i7.LoginMnemonicPage(),
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i8.ValidatorsPage(),
          opaque: true,
          barrierDismissible: false);
    },
    WelcomeRoute.name: (routeData) {
      return _i10.CustomPage<void>(
          routeData: routeData,
          child: const _i9.WelcomePage(),
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(PagesRoute.name, path: '/', children: [
          _i10.RouteConfig(AccountsRoute.name,
              path: 'accounts', parent: PagesRoute.name),
          _i10.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: PagesRoute.name),
          _i10.RouteConfig(CreateWalletRoute.name,
              path: 'create-wallet', parent: PagesRoute.name),
          _i10.RouteConfig(ConnectionRoute.name,
              path: 'connection', parent: PagesRoute.name),
          _i10.RouteConfig(LoginKeyfileRoute.name,
              path: 'login-keyfile', parent: PagesRoute.name),
          _i10.RouteConfig(LoginMnemonicRoute.name,
              path: 'login-mnemonic', parent: PagesRoute.name),
          _i10.RouteConfig(ValidatorsRoute.name,
              path: 'validators', parent: PagesRoute.name),
          _i10.RouteConfig(WelcomeRoute.name,
              path: 'welcome', parent: PagesRoute.name),
          _i10.RouteConfig('#redirect',
              path: '',
              parent: PagesRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true)
        ]),
        _i10.RouteConfig('#redirect',
            path: '', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.PagesWrapper]
class PagesRoute extends _i10.PageRouteInfo<void> {
  const PagesRoute({List<_i10.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i2.AccountsPage]
class AccountsRoute extends _i10.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i3.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i4.CreateWalletPage]
class CreateWalletRoute extends _i10.PageRouteInfo<void> {
  const CreateWalletRoute() : super(name, path: 'create-wallet');

  static const String name = 'CreateWalletRoute';
}

/// generated route for [_i5.ConnectionDrawerPage]
class ConnectionRoute extends _i10.PageRouteInfo<void> {
  const ConnectionRoute() : super(name, path: 'connection');

  static const String name = 'ConnectionRoute';
}

/// generated route for [_i6.LoginKeyfilePage]
class LoginKeyfileRoute extends _i10.PageRouteInfo<void> {
  const LoginKeyfileRoute() : super(name, path: 'login-keyfile');

  static const String name = 'LoginKeyfileRoute';
}

/// generated route for [_i7.LoginMnemonicPage]
class LoginMnemonicRoute extends _i10.PageRouteInfo<void> {
  const LoginMnemonicRoute() : super(name, path: 'login-mnemonic');

  static const String name = 'LoginMnemonicRoute';
}

/// generated route for [_i8.ValidatorsPage]
class ValidatorsRoute extends _i10.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i9.WelcomePage]
class WelcomeRoute extends _i10.PageRouteInfo<void> {
  const WelcomeRoute() : super(name, path: 'welcome');

  static const String name = 'WelcomeRoute';
}
