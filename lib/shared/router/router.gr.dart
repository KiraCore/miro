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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i3;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i4;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i6;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i5;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i2;
import '../../views/pages/transactions/tx_confirm_page/tx_confirm_page.dart'
    as _i8;
import '../../views/pages/transactions/tx_form_page/send/tx_tokens_send_form_page.dart'
    as _i7;
import '../guards/auth_guard.dart' as _i12;
import '../guards/navigation_guard.dart' as _i13;
import '../guards/url_parameters_guard.dart' as _i11;
import '../models/balances/balance_model.dart' as _i14;
import '../models/transactions/signed_transaction_model.dart' as _i15;

class AppRouter extends _i9.RootStackRouter {
  AppRouter({
    _i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
    required this.urlParametersGuard,
    required this.authGuard,
    required this.navigationGuard,
  }) : super(navigatorKey);

  final _i11.UrlParametersGuard urlParametersGuard;

  final _i12.AuthGuard authGuard;

  final _i13.NavigationGuard navigationGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i1.PagesWrapper(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i2.TransactionsWrapper(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AccountsRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i3.AccountsPage(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i4.DashboardPage(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i5.ValidatorsPage(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: const _i6.MyAccountPage(),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxTokensSendFormRoute.name: (routeData) {
      final args = routeData.argsAs<TxTokensSendFormRouteArgs>(
          orElse: () => const TxTokensSendFormRouteArgs());
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: _i7.TxTokensSendFormPage(
          initialBalanceModel: args.initialBalanceModel,
          key: args.key,
        ),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxConfirmRoute.name: (routeData) {
      final args = routeData.argsAs<TxConfirmRouteArgs>();
      return _i9.CustomPage<void>(
        routeData: routeData,
        child: _i8.TxConfirmPage(
          signedTxModel: args.signedTxModel,
          key: args.key,
        ),
        transitionsBuilder: _i9.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          PagesRoute.name,
          path: '/',
          guards: [urlParametersGuard],
          children: [
            _i9.RouteConfig(
              AccountsRoute.name,
              path: 'accounts',
              parent: PagesRoute.name,
              guards: [
                urlParametersGuard,
                navigationGuard,
              ],
            ),
            _i9.RouteConfig(
              DashboardRoute.name,
              path: 'dashboard',
              parent: PagesRoute.name,
              guards: [
                urlParametersGuard,
                navigationGuard,
              ],
            ),
            _i9.RouteConfig(
              ValidatorsRoute.name,
              path: 'validators',
              parent: PagesRoute.name,
              guards: [
                urlParametersGuard,
                navigationGuard,
              ],
            ),
            _i9.RouteConfig(
              MyAccountRoute.name,
              path: 'my-account',
              parent: PagesRoute.name,
              guards: [
                authGuard,
                urlParametersGuard,
                navigationGuard,
              ],
            ),
            _i9.RouteConfig(
              '#redirect',
              path: '',
              parent: PagesRoute.name,
              redirectTo: 'dashboard',
              fullMatch: true,
            ),
          ],
        ),
        _i9.RouteConfig(
          TransactionsWrapperRoute.name,
          path: '/transactions',
          guards: [
            authGuard,
            urlParametersGuard,
          ],
          children: [
            _i9.RouteConfig(
              TxTokensSendFormRoute.name,
              path: 'tokens/send',
              parent: TransactionsWrapperRoute.name,
              guards: [
                authGuard,
                urlParametersGuard,
              ],
            ),
            _i9.RouteConfig(
              TxConfirmRoute.name,
              path: 'transaction/confirm',
              parent: TransactionsWrapperRoute.name,
              guards: [
                authGuard,
                urlParametersGuard,
              ],
            ),
          ],
        ),
        _i9.RouteConfig(
          '#redirect',
          path: '',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesRoute extends _i9.PageRouteInfo<void> {
  const PagesRoute({List<_i9.PageRouteInfo>? children})
      : super(
          PagesRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'PagesRoute';
}

/// generated route for
/// [_i2.TransactionsWrapper]
class TransactionsWrapperRoute extends _i9.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          path: '/transactions',
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i3.AccountsPage]
class AccountsRoute extends _i9.PageRouteInfo<void> {
  const AccountsRoute()
      : super(
          AccountsRoute.name,
          path: 'accounts',
        );

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i5.ValidatorsPage]
class ValidatorsRoute extends _i9.PageRouteInfo<void> {
  const ValidatorsRoute()
      : super(
          ValidatorsRoute.name,
          path: 'validators',
        );

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i6.MyAccountPage]
class MyAccountRoute extends _i9.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(
          MyAccountRoute.name,
          path: 'my-account',
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i7.TxTokensSendFormPage]
class TxTokensSendFormRoute
    extends _i9.PageRouteInfo<TxTokensSendFormRouteArgs> {
  TxTokensSendFormRoute({
    _i14.BalanceModel? initialBalanceModel,
    _i10.Key? key,
  }) : super(
          TxTokensSendFormRoute.name,
          path: 'tokens/send',
          args: TxTokensSendFormRouteArgs(
            initialBalanceModel: initialBalanceModel,
            key: key,
          ),
        );

  static const String name = 'TxTokensSendFormRoute';
}

class TxTokensSendFormRouteArgs {
  const TxTokensSendFormRouteArgs({
    this.initialBalanceModel,
    this.key,
  });

  final _i14.BalanceModel? initialBalanceModel;

  final _i10.Key? key;

  @override
  String toString() {
    return 'TxTokensSendFormRouteArgs{initialBalanceModel: $initialBalanceModel, key: $key}';
  }
}

/// generated route for
/// [_i8.TxConfirmPage]
class TxConfirmRoute extends _i9.PageRouteInfo<TxConfirmRouteArgs> {
  TxConfirmRoute({
    required _i15.SignedTxModel signedTxModel,
    _i10.Key? key,
  }) : super(
          TxConfirmRoute.name,
          path: 'transaction/confirm',
          args: TxConfirmRouteArgs(
            signedTxModel: signedTxModel,
            key: key,
          ),
        );

  static const String name = 'TxConfirmRoute';
}

class TxConfirmRouteArgs {
  const TxConfirmRouteArgs({
    required this.signedTxModel,
    this.key,
  });

  final _i15.SignedTxModel signedTxModel;

  final _i10.Key? key;

  @override
  String toString() {
    return 'TxConfirmRouteArgs{signedTxModel: $signedTxModel, key: $key}';
  }
}
