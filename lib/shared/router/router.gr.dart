// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../views/pages/dialog/dialog_wrapper.dart' as _i2;
import '../../views/pages/dialog/transactions/generic_transaction_page/generic_transaction_page.dart' as _i7;
import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i3;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i4;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i6;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i5;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../guards/auth_guard.dart' as _i12;
import '../guards/navigation_guard.dart' as _i11;
import '../guards/url_parameters_guard.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter(
      {_i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
      required this.urlParametersGuard,
      required this.navigationGuard,
      required this.authGuard})
      : super(navigatorKey);

  final _i10.UrlParametersGuard urlParametersGuard;

  final _i11.NavigationGuard navigationGuard;

  final _i12.AuthGuard authGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData, child: const _i1.PagesWrapper(), opaque: true, barrierDismissible: false);
    },
    DialogWrapperRoute.name: (routeData) {
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: const _i2.DialogWrapper(),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
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
    GenericTransactionRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<GenericTransactionRouteArgs>(
          orElse: () => GenericTransactionRouteArgs(
              messageType: queryParams.getString('messageType', 'MsgSend'), metadata: queryParams.get('metadata')));
      return _i8.CustomPage<void>(
          routeData: routeData,
          child: _i7.GenericTransactionPage(messageType: args.messageType, metadata: args.metadata, key: args.key),
          transitionsBuilder: _i8.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(PagesRoute.name, path: '/', guards: [
          urlParametersGuard
        ], children: [
          _i8.RouteConfig(AccountsRoute.name,
              path: 'accounts', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(ValidatorsRoute.name,
              path: 'validators', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i8.RouteConfig(MyAccountRoute.name,
              path: 'my-account', parent: PagesRoute.name, guards: [authGuard, urlParametersGuard, navigationGuard]),
          _i8.RouteConfig('#redirect', path: '', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i8.RouteConfig(DialogWrapperRoute.name, path: '/d', children: [
          _i8.RouteConfig(GenericTransactionRoute.name, path: 'transaction/create', parent: DialogWrapperRoute.name),
          _i8.RouteConfig('*#redirect', path: '*', parent: DialogWrapperRoute.name, redirectTo: '/', fullMatch: true)
        ]),
        _i8.RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.PagesWrapper]
class PagesRoute extends _i8.PageRouteInfo<void> {
  const PagesRoute({List<_i8.PageRouteInfo>? children}) : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i2.DialogWrapper]
class DialogWrapperRoute extends _i8.PageRouteInfo<void> {
  const DialogWrapperRoute({List<_i8.PageRouteInfo>? children}) : super(name, path: '/d', initialChildren: children);

  static const String name = 'DialogWrapperRoute';
}

/// generated route for [_i3.AccountsPage]
class AccountsRoute extends _i8.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i4.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i5.ValidatorsPage]
class ValidatorsRoute extends _i8.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i6.MyAccountPage]
class MyAccountRoute extends _i8.PageRouteInfo<void> {
  const MyAccountRoute() : super(name, path: 'my-account');

  static const String name = 'MyAccountRoute';
}

/// generated route for [_i7.GenericTransactionPage]
class GenericTransactionRoute extends _i8.PageRouteInfo<GenericTransactionRouteArgs> {
  GenericTransactionRoute({String messageType = 'MsgSend', Map<String, dynamic>? metadata, _i9.Key? key})
      : super(name,
            path: 'transaction/create',
            args: GenericTransactionRouteArgs(messageType: messageType, metadata: metadata, key: key),
            rawQueryParams: {'messageType': messageType, 'metadata': metadata});

  static const String name = 'GenericTransactionRoute';
}

class GenericTransactionRouteArgs {
  const GenericTransactionRouteArgs({this.messageType = 'MsgSend', this.metadata, this.key});

  final String messageType;

  final Map<String, dynamic>? metadata;

  final _i9.Key? key;

  @override
  String toString() {
    return 'GenericTransactionRouteArgs{messageType: $messageType, metadata: $metadata, key: $key}';
  }
}
