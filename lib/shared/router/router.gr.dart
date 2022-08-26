// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i3;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i4;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i6;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i5;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/send/msg_send_create_page.dart' as _i7;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i2;
import '../guards/auth_guard.dart' as _i11;
import '../guards/navigation_guard.dart' as _i12;
import '../guards/url_parameters_guard.dart' as _i10;
import '../models/balances/balance_model.dart' as _i13;

class AppRouter extends _i8.RootStackRouter {
  AppRouter(
      {_i9.GlobalKey<_i9.NavigatorState>? navigatorKey, required this.urlParametersGuard, required this.authGuard, required this.navigationGuard})
      : super(navigatorKey);

  final _i10.UrlParametersGuard urlParametersGuard;

  final _i11.AuthGuard authGuard;

  final _i12.NavigationGuard navigationGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i8.CustomPage<void>(routeData: routeData, child: const _i1.PagesWrapper(), opaque: true, barrierDismissible: false);
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i2.TransactionsWrapper(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i3.AccountsPage(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i4.DashboardPage(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i5.ValidatorsPage(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyAccountRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i6.MyAccountPage(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MsgSendCreateRoute.name: (routeData) {
      final args = routeData.argsAs<MsgSendCreateRouteArgs>(orElse: () => const MsgSendCreateRouteArgs());
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: _i7.MsgSendCreatePage(initialBalanceModel: args.initialBalanceModel, key: args.key),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(PagesRoute.name, path: '/', guards: [
          urlParametersGuard
        ], children: [
          _i8.RouteConfig(AccountsRoute.name, path: 'accounts', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(DashboardRoute.name, path: 'dashboard', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(ValidatorsRoute.name, path: 'validators', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(MyAccountRoute.name, path: 'my-account', parent: PagesRoute.name, guards: [authGuard, urlParametersGuard, navigationGuard]),
          _i8.RouteConfig('#redirect', path: '', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i8.RouteConfig(TransactionsWrapperRoute.name, path: '/transactions', guards: [
          authGuard,
          urlParametersGuard
        ], children: [
          _i8.RouteConfig(MsgSendCreateRoute.name,
              path: 'tokens/send', parent: TransactionsWrapperRoute.name, guards: [authGuard, urlParametersGuard])
        ]),
        _i8.RouteConfig('#redirect', path: '', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesRoute extends _i8.PageRouteInfo<void> {
  const PagesRoute({List<_i8.PageRouteInfo>? children}) : super(PagesRoute.name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for
/// [_i2.TransactionsWrapper]
class TransactionsWrapperRoute extends _i8.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i8.PageRouteInfo>? children})
      : super(TransactionsWrapperRoute.name, path: '/transactions', initialChildren: children);

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i3.AccountsPage]
class AccountsRoute extends _i8.PageRouteInfo<void> {
  const AccountsRoute() : super(AccountsRoute.name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i5.ValidatorsPage]
class ValidatorsRoute extends _i8.PageRouteInfo<void> {
  const ValidatorsRoute() : super(ValidatorsRoute.name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i6.MyAccountPage]
class MyAccountRoute extends _i8.PageRouteInfo<void> {
  const MyAccountRoute() : super(MyAccountRoute.name, path: 'my-account');

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i7.MsgSendCreatePage]
class MsgSendCreateRoute extends _i8.PageRouteInfo<MsgSendCreateRouteArgs> {
  MsgSendCreateRoute({_i13.BalanceModel? initialBalanceModel, _i9.Key? key})
      : super(MsgSendCreateRoute.name, path: 'tokens/send', args: MsgSendCreateRouteArgs(initialBalanceModel: initialBalanceModel, key: key));

  static const String name = 'MsgSendCreateRoute';
}

class MsgSendCreateRouteArgs {
  const MsgSendCreateRouteArgs({this.initialBalanceModel, this.key});

  final _i13.BalanceModel? initialBalanceModel;

  final _i9.Key? key;

  @override
  String toString() {
    return 'MsgSendCreateRouteArgs{initialBalanceModel: $initialBalanceModel, key: $key}';
  }
}
