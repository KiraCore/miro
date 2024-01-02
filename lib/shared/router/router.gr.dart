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
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../views/pages/loading/loading_page/loading_page.dart' as _i6;
import '../../views/pages/loading/loading_wrapper.dart' as _i2;
import '../../views/pages/loading/network_list_page/network_list_page.dart'
    as _i5;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i7;
import '../../views/pages/menu/menu_wrapper.dart' as _i3;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i10;
import '../../views/pages/menu/proposals_page/proposals_page.dart' as _i9;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i8;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i4;
import '../../views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_page.dart'
    as _i11;
import '../models/balances/balance_model.dart' as _i20;
import '../models/network/connection/connection_error_type.dart' as _i18;
import '../models/network/status/a_network_status_model.dart' as _i19;
import 'guards/auth_guard.dart' as _i15;
import 'guards/connection_guard.dart' as _i14;
import 'guards/navigation_guard.dart' as _i17;
import 'guards/pages/loading_page_guard.dart' as _i16;

class AppRouter extends _i12.RootStackRouter {
  AppRouter({
    _i13.GlobalKey<_i13.NavigatorState>? navigatorKey,
    required this.connectionGuard,
    required this.authGuard,
    required this.loadingPageGuard,
    required this.navigationGuard,
  }) : super(navigatorKey);

  final _i14.ConnectionGuard connectionGuard;

  final _i15.AuthGuard authGuard;

  final _i16.LoadingPageGuard loadingPageGuard;

  final _i17.NavigationGuard navigationGuard;

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    PagesWrapperRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i1.PagesWrapper(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingWrapperRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i2.LoadingWrapper(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i3.MenuWrapper(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 1000,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TransactionsWrapper(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NetworkListRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkListRouteArgs>(
          orElse: () => const NetworkListRouteArgs());
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: _i5.NetworkListPage(
          connectionErrorType: args.connectionErrorType,
          canceledNetworkStatusModel: args.canceledNetworkStatusModel,
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(
          orElse: () => const LoadingRouteArgs());
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: _i6.LoadingPage(
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i7.DashboardPage(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i8.ValidatorsPage(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProposalsRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i9.ProposalsPage(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: const _i10.MyAccountPage(),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxSendTokensRoute.name: (routeData) {
      final args = routeData.argsAs<TxSendTokensRouteArgs>(
          orElse: () => const TxSendTokensRouteArgs());
      return _i12.CustomPage<void>(
        routeData: routeData,
        child: _i11.TxSendTokensPage(
          defaultBalanceModel: args.defaultBalanceModel,
          key: args.key,
        ),
        transitionsBuilder: _i12.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          PagesWrapperRoute.name,
          path: '/',
          guards: [connectionGuard],
          children: [
            _i12.RouteConfig(
              '#redirect',
              path: '',
              parent: PagesWrapperRoute.name,
              redirectTo: 'network',
              fullMatch: true,
            ),
            _i12.RouteConfig(
              LoadingWrapperRoute.name,
              path: 'network',
              parent: PagesWrapperRoute.name,
              children: [
                _i12.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: LoadingWrapperRoute.name,
                  redirectTo: 'list',
                  fullMatch: true,
                ),
                _i12.RouteConfig(
                  NetworkListRoute.name,
                  path: 'list',
                  parent: LoadingWrapperRoute.name,
                ),
                _i12.RouteConfig(
                  LoadingRoute.name,
                  path: 'loading',
                  parent: LoadingWrapperRoute.name,
                  guards: [loadingPageGuard],
                ),
              ],
            ),
            _i12.RouteConfig(
              MenuWrapperRoute.name,
              path: 'app',
              parent: PagesWrapperRoute.name,
              children: [
                _i12.RouteConfig(
                  DashboardRoute.name,
                  path: 'dashboard',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i12.RouteConfig(
                  ValidatorsRoute.name,
                  path: 'validators',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i12.RouteConfig(
                  ProposalsRoute.name,
                  path: 'proposals',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i12.RouteConfig(
                  MyAccountRoute.name,
                  path: 'my-account',
                  parent: MenuWrapperRoute.name,
                  guards: [
                    authGuard,
                    navigationGuard,
                  ],
                ),
              ],
            ),
            _i12.RouteConfig(
              TransactionsWrapperRoute.name,
              path: 'transactions',
              parent: PagesWrapperRoute.name,
              guards: [authGuard],
              children: [
                _i12.RouteConfig(
                  TxSendTokensRoute.name,
                  path: 'tokens/send',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                )
              ],
            ),
          ],
        ),
        _i12.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesWrapperRoute extends _i12.PageRouteInfo<void> {
  const PagesWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          PagesWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'PagesWrapperRoute';
}

/// generated route for
/// [_i2.LoadingWrapper]
class LoadingWrapperRoute extends _i12.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          LoadingWrapperRoute.name,
          path: 'network',
          initialChildren: children,
        );

  static const String name = 'LoadingWrapperRoute';
}

/// generated route for
/// [_i3.MenuWrapper]
class MenuWrapperRoute extends _i12.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          path: 'app',
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';
}

/// generated route for
/// [_i4.TransactionsWrapper]
class TransactionsWrapperRoute extends _i12.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i12.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          path: 'transactions',
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i5.NetworkListPage]
class NetworkListRoute extends _i12.PageRouteInfo<NetworkListRouteArgs> {
  NetworkListRoute({
    _i18.ConnectionErrorType connectionErrorType =
        _i18.ConnectionErrorType.canceledByUser,
    _i19.ANetworkStatusModel? canceledNetworkStatusModel,
    _i12.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i13.Key? key,
  }) : super(
          NetworkListRoute.name,
          path: 'list',
          args: NetworkListRouteArgs(
            connectionErrorType: connectionErrorType,
            canceledNetworkStatusModel: canceledNetworkStatusModel,
            nextPageRouteInfo: nextPageRouteInfo,
            key: key,
          ),
        );

  static const String name = 'NetworkListRoute';
}

class NetworkListRouteArgs {
  const NetworkListRouteArgs({
    this.connectionErrorType = _i18.ConnectionErrorType.canceledByUser,
    this.canceledNetworkStatusModel,
    this.nextPageRouteInfo,
    this.key,
  });

  final _i18.ConnectionErrorType connectionErrorType;

  final _i19.ANetworkStatusModel? canceledNetworkStatusModel;

  final _i12.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i13.Key? key;

  @override
  String toString() {
    return 'NetworkListRouteArgs{connectionErrorType: $connectionErrorType, canceledNetworkStatusModel: $canceledNetworkStatusModel, nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i6.LoadingPage]
class LoadingRoute extends _i12.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    _i12.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i13.Key? key,
  }) : super(
          LoadingRoute.name,
          path: 'loading',
          args: LoadingRouteArgs(
            nextPageRouteInfo: nextPageRouteInfo,
            key: key,
          ),
        );

  static const String name = 'LoadingRoute';
}

class LoadingRouteArgs {
  const LoadingRouteArgs({
    this.nextPageRouteInfo,
    this.key,
  });

  final _i12.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i13.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i7.DashboardPage]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i8.ValidatorsPage]
class ValidatorsRoute extends _i12.PageRouteInfo<void> {
  const ValidatorsRoute()
      : super(
          ValidatorsRoute.name,
          path: 'validators',
        );

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i9.ProposalsPage]
class ProposalsRoute extends _i12.PageRouteInfo<void> {
  const ProposalsRoute()
      : super(
          ProposalsRoute.name,
          path: 'proposals',
        );

  static const String name = 'ProposalsRoute';
}

/// generated route for
/// [_i10.MyAccountPage]
class MyAccountRoute extends _i12.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(
          MyAccountRoute.name,
          path: 'my-account',
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i11.TxSendTokensPage]
class TxSendTokensRoute extends _i12.PageRouteInfo<TxSendTokensRouteArgs> {
  TxSendTokensRoute({
    _i20.BalanceModel? defaultBalanceModel,
    _i13.Key? key,
  }) : super(
          TxSendTokensRoute.name,
          path: 'tokens/send',
          args: TxSendTokensRouteArgs(
            defaultBalanceModel: defaultBalanceModel,
            key: key,
          ),
        );

  static const String name = 'TxSendTokensRoute';
}

class TxSendTokensRouteArgs {
  const TxSendTokensRouteArgs({
    this.defaultBalanceModel,
    this.key,
  });

  final _i20.BalanceModel? defaultBalanceModel;

  final _i13.Key? key;

  @override
  String toString() {
    return 'TxSendTokensRouteArgs{defaultBalanceModel: $defaultBalanceModel, key: $key}';
  }
}
