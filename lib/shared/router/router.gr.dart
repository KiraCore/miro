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
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import '../../views/pages/loading/loading_page/loading_page.dart' as _i5;
import '../../views/pages/loading/loading_wrapper.dart' as _i2;
import '../../views/pages/loading/network_list_page/network_list_page.dart'
    as _i6;
import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i7;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i8;
import '../../views/pages/menu/menu_wrapper.dart' as _i3;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i10;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i9;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i4;
import '../../views/pages/transactions/tx_broadcast_page/tx_broadcast_page.dart'
    as _i13;
import '../../views/pages/transactions/tx_confirm_page/tx_confirm_page.dart'
    as _i12;
import '../../views/pages/transactions/tx_form_page/send/tx_tokens_send_form_page.dart'
    as _i11;
import '../guards/auth_guard.dart' as _i17;
import '../guards/connection_guard.dart' as _i16;
import '../guards/navigation_guard.dart' as _i19;
import '../guards/url_parameters_guard.dart' as _i18;
import '../models/balances/balance_model.dart' as _i22;
import '../models/network/connection/connection_error_type.dart' as _i20;
import '../models/network/status/a_network_status_model.dart' as _i21;
import '../models/tokens/token_denomination_model.dart' as _i24;
import '../models/transactions/signed_transaction_model.dart' as _i23;

class AppRouter extends _i14.RootStackRouter {
  AppRouter({
    _i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
    required this.connectionGuard,
    required this.authGuard,
    required this.urlParametersGuard,
    required this.navigationGuard,
  }) : super(navigatorKey);

  final _i16.ConnectionGuard connectionGuard;

  final _i17.AuthGuard authGuard;

  final _i18.UrlParametersGuard urlParametersGuard;

  final _i19.NavigationGuard navigationGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    PagesWrapperRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i1.PagesWrapper(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingWrapperRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i2.LoadingWrapper(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MenuRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i3.MenuWrapper(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 1000,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TransactionsWrapper(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(
          orElse: () => const LoadingRouteArgs());
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: _i5.LoadingPage(
          nextRoute: args.nextRoute,
          key: args.key,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NetworkListRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkListRouteArgs>();
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: _i6.NetworkListPage(
          connectionErrorType: args.connectionErrorType,
          canceledNetworkStatusModel: args.canceledNetworkStatusModel,
          nextRoute: args.nextRoute,
          key: args.key,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    AccountsRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i7.AccountsPage(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i8.DashboardPage(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i9.ValidatorsPage(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: const _i10.MyAccountPage(),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxTokensSendFormRoute.name: (routeData) {
      final args = routeData.argsAs<TxTokensSendFormRouteArgs>(
          orElse: () => const TxTokensSendFormRouteArgs());
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: _i11.TxTokensSendFormPage(
          initialBalanceModel: args.initialBalanceModel,
          key: args.key,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxConfirmRoute.name: (routeData) {
      final args = routeData.argsAs<TxConfirmRouteArgs>();
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: _i12.TxConfirmPage(
          signedTxModel: args.signedTxModel,
          tokenDenominationModel: args.tokenDenominationModel,
          key: args.key,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxBroadcastRoute.name: (routeData) {
      final args = routeData.argsAs<TxBroadcastRouteArgs>();
      return _i14.CustomPage<void>(
        routeData: routeData,
        child: _i13.TxBroadcastPage(
          signedTxModel: args.signedTxModel,
          key: args.key,
        ),
        transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(
          PagesWrapperRoute.name,
          path: '/',
          guards: [connectionGuard],
          children: [
            _i14.RouteConfig(
              LoadingWrapperRoute.name,
              path: 'network',
              parent: PagesWrapperRoute.name,
              children: [
                _i14.RouteConfig(
                  LoadingRoute.name,
                  path: 'loading',
                  parent: LoadingWrapperRoute.name,
                ),
                _i14.RouteConfig(
                  NetworkListRoute.name,
                  path: 'list',
                  parent: LoadingWrapperRoute.name,
                ),
                _i14.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: LoadingWrapperRoute.name,
                  redirectTo: 'list',
                  fullMatch: true,
                ),
              ],
            ),
            _i14.RouteConfig(
              MenuRoute.name,
              path: 'app',
              parent: PagesWrapperRoute.name,
              children: [
                _i14.RouteConfig(
                  AccountsRoute.name,
                  path: 'accounts',
                  parent: MenuRoute.name,
                  guards: [
                    urlParametersGuard,
                    navigationGuard,
                  ],
                ),
                _i14.RouteConfig(
                  DashboardRoute.name,
                  path: 'dashboard',
                  parent: MenuRoute.name,
                  guards: [
                    urlParametersGuard,
                    navigationGuard,
                  ],
                ),
                _i14.RouteConfig(
                  ValidatorsRoute.name,
                  path: 'validators',
                  parent: MenuRoute.name,
                  guards: [
                    urlParametersGuard,
                    navigationGuard,
                  ],
                ),
                _i14.RouteConfig(
                  MyAccountRoute.name,
                  path: 'my-account',
                  parent: MenuRoute.name,
                  guards: [
                    authGuard,
                    urlParametersGuard,
                    navigationGuard,
                  ],
                ),
                _i14.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: MenuRoute.name,
                  redirectTo: 'dashboard',
                  fullMatch: true,
                ),
              ],
            ),
            _i14.RouteConfig(
              TransactionsWrapperRoute.name,
              path: 'transactions',
              parent: PagesWrapperRoute.name,
              guards: [
                authGuard,
                urlParametersGuard,
              ],
              children: [
                _i14.RouteConfig(
                  TxTokensSendFormRoute.name,
                  path: 'tokens/send',
                  parent: TransactionsWrapperRoute.name,
                  guards: [
                    authGuard,
                    urlParametersGuard,
                  ],
                ),
                _i14.RouteConfig(
                  TxConfirmRoute.name,
                  path: 'transaction/confirm',
                  parent: TransactionsWrapperRoute.name,
                  guards: [
                    authGuard,
                    urlParametersGuard,
                  ],
                ),
                _i14.RouteConfig(
                  TxBroadcastRoute.name,
                  path: 'transaction/broadcast',
                  parent: TransactionsWrapperRoute.name,
                  guards: [
                    authGuard,
                    urlParametersGuard,
                  ],
                ),
                _i14.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: TransactionsWrapperRoute.name,
                  redirectTo: '/app',
                  fullMatch: true,
                ),
              ],
            ),
            _i14.RouteConfig(
              '#redirect',
              path: '',
              parent: PagesWrapperRoute.name,
              redirectTo: 'app',
              fullMatch: true,
            ),
          ],
        ),
        _i14.RouteConfig(
          '#redirect',
          path: '',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesWrapperRoute extends _i14.PageRouteInfo<void> {
  const PagesWrapperRoute({List<_i14.PageRouteInfo>? children})
      : super(
          PagesWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'PagesWrapperRoute';
}

/// generated route for
/// [_i2.LoadingWrapper]
class LoadingWrapperRoute extends _i14.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoadingWrapperRoute.name,
          path: 'network',
          initialChildren: children,
        );

  static const String name = 'LoadingWrapperRoute';
}

/// generated route for
/// [_i3.MenuWrapper]
class MenuRoute extends _i14.PageRouteInfo<void> {
  const MenuRoute({List<_i14.PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          path: 'app',
          initialChildren: children,
        );

  static const String name = 'MenuRoute';
}

/// generated route for
/// [_i4.TransactionsWrapper]
class TransactionsWrapperRoute extends _i14.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i14.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          path: 'transactions',
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i5.LoadingPage]
class LoadingRoute extends _i14.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    _i14.RouteMatch<dynamic>? nextRoute,
    _i15.Key? key,
  }) : super(
          LoadingRoute.name,
          path: 'loading',
          args: LoadingRouteArgs(
            nextRoute: nextRoute,
            key: key,
          ),
        );

  static const String name = 'LoadingRoute';
}

class LoadingRouteArgs {
  const LoadingRouteArgs({
    this.nextRoute,
    this.key,
  });

  final _i14.RouteMatch<dynamic>? nextRoute;

  final _i15.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextRoute: $nextRoute, key: $key}';
  }
}

/// generated route for
/// [_i6.NetworkListPage]
class NetworkListRoute extends _i14.PageRouteInfo<NetworkListRouteArgs> {
  NetworkListRoute({
    required _i20.ConnectionErrorType connectionErrorType,
    _i21.ANetworkStatusModel? canceledNetworkStatusModel,
    _i14.RouteMatch<dynamic>? nextRoute,
    _i15.Key? key,
  }) : super(
          NetworkListRoute.name,
          path: 'list',
          args: NetworkListRouteArgs(
            connectionErrorType: connectionErrorType,
            canceledNetworkStatusModel: canceledNetworkStatusModel,
            nextRoute: nextRoute,
            key: key,
          ),
        );

  static const String name = 'NetworkListRoute';
}

class NetworkListRouteArgs {
  const NetworkListRouteArgs({
    required this.connectionErrorType,
    this.canceledNetworkStatusModel,
    this.nextRoute,
    this.key,
  });

  final _i20.ConnectionErrorType connectionErrorType;

  final _i21.ANetworkStatusModel? canceledNetworkStatusModel;

  final _i14.RouteMatch<dynamic>? nextRoute;

  final _i15.Key? key;

  @override
  String toString() {
    return 'NetworkListRouteArgs{connectionErrorType: $connectionErrorType, canceledNetworkStatusModel: $canceledNetworkStatusModel, nextRoute: $nextRoute, key: $key}';
  }
}

/// generated route for
/// [_i7.AccountsPage]
class AccountsRoute extends _i14.PageRouteInfo<void> {
  const AccountsRoute()
      : super(
          AccountsRoute.name,
          path: 'accounts',
        );

  static const String name = 'AccountsRoute';
}

/// generated route for
/// [_i8.DashboardPage]
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i9.ValidatorsPage]
class ValidatorsRoute extends _i14.PageRouteInfo<void> {
  const ValidatorsRoute()
      : super(
          ValidatorsRoute.name,
          path: 'validators',
        );

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i10.MyAccountPage]
class MyAccountRoute extends _i14.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(
          MyAccountRoute.name,
          path: 'my-account',
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i11.TxTokensSendFormPage]
class TxTokensSendFormRoute
    extends _i14.PageRouteInfo<TxTokensSendFormRouteArgs> {
  TxTokensSendFormRoute({
    _i22.BalanceModel? initialBalanceModel,
    _i15.Key? key,
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

  final _i22.BalanceModel? initialBalanceModel;

  final _i15.Key? key;

  @override
  String toString() {
    return 'TxTokensSendFormRouteArgs{initialBalanceModel: $initialBalanceModel, key: $key}';
  }
}

/// generated route for
/// [_i12.TxConfirmPage]
class TxConfirmRoute extends _i14.PageRouteInfo<TxConfirmRouteArgs> {
  TxConfirmRoute({
    required _i23.SignedTxModel signedTxModel,
    _i24.TokenDenominationModel? tokenDenominationModel,
    _i15.Key? key,
  }) : super(
          TxConfirmRoute.name,
          path: 'transaction/confirm',
          args: TxConfirmRouteArgs(
            signedTxModel: signedTxModel,
            tokenDenominationModel: tokenDenominationModel,
            key: key,
          ),
        );

  static const String name = 'TxConfirmRoute';
}

class TxConfirmRouteArgs {
  const TxConfirmRouteArgs({
    required this.signedTxModel,
    this.tokenDenominationModel,
    this.key,
  });

  final _i23.SignedTxModel signedTxModel;

  final _i24.TokenDenominationModel? tokenDenominationModel;

  final _i15.Key? key;

  @override
  String toString() {
    return 'TxConfirmRouteArgs{signedTxModel: $signedTxModel, tokenDenominationModel: $tokenDenominationModel, key: $key}';
  }
}

/// generated route for
/// [_i13.TxBroadcastPage]
class TxBroadcastRoute extends _i14.PageRouteInfo<TxBroadcastRouteArgs> {
  TxBroadcastRoute({
    required _i23.SignedTxModel signedTxModel,
    _i15.Key? key,
  }) : super(
          TxBroadcastRoute.name,
          path: 'transaction/broadcast',
          args: TxBroadcastRouteArgs(
            signedTxModel: signedTxModel,
            key: key,
          ),
        );

  static const String name = 'TxBroadcastRoute';
}

class TxBroadcastRouteArgs {
  const TxBroadcastRouteArgs({
    required this.signedTxModel,
    this.key,
  });

  final _i23.SignedTxModel signedTxModel;

  final _i15.Key? key;

  @override
  String toString() {
    return 'TxBroadcastRouteArgs{signedTxModel: $signedTxModel, key: $key}';
  }
}
