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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../../views/pages/loading/loading_page/loading_page.dart' as _i6;
import '../../views/pages/loading/loading_wrapper.dart' as _i2;
import '../../views/pages/loading/network_list_page/network_list_page.dart' as _i5;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i7;
import '../../views/pages/menu/menu_wrapper.dart' as _i3;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i9;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i8;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i4;
import '../../views/pages/transactions/tx_broadcast_page/tx_broadcast_page.dart' as _i12;
import '../../views/pages/transactions/tx_confirm_page/tx_confirm_page.dart' as _i11;
import '../../views/pages/transactions/tx_form_page/send/tx_tokens_send_form_page.dart' as _i10;
import '../models/balances/balance_model.dart' as _i23;
import '../models/network/connection/connection_error_type.dart' as _i21;
import '../models/network/status/a_network_status_model.dart' as _i22;
import '../models/tokens/token_denomination_model.dart' as _i25;
import '../models/transactions/signed_transaction_model.dart' as _i24;
import 'guards/auth_guard.dart' as _i16;
import 'guards/connection_guard.dart' as _i15;
import 'guards/navigation_guard.dart' as _i18;
import 'guards/pages/loading_page_guard.dart' as _i17;
import 'guards/pages/tx_broadcast_page_guard.dart' as _i20;
import 'guards/pages/tx_confirm_page_guard.dart' as _i19;

class AppRouter extends _i13.RootStackRouter {
  AppRouter({
    _i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
    required this.connectionGuard,
    required this.authGuard,
    required this.loadingPageGuard,
    required this.navigationGuard,
    required this.txConfirmPageGuard,
    required this.txBroadcastPageGuard,
  }) : super(navigatorKey);

  final _i15.ConnectionGuard connectionGuard;

  final _i16.AuthGuard authGuard;

  final _i17.LoadingPageGuard loadingPageGuard;

  final _i18.NavigationGuard navigationGuard;

  final _i19.TxConfirmPageGuard txConfirmPageGuard;

  final _i20.TxBroadcastPageGuard txBroadcastPageGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    PagesWrapperRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i1.PagesWrapper(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingWrapperRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i2.LoadingWrapper(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i3.MenuWrapper(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 1000,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TransactionsWrapper(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NetworkListRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkListRouteArgs>(
          orElse: () => const NetworkListRouteArgs());
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: _i5.NetworkListPage(
          connectionErrorType: args.connectionErrorType,
          canceledNetworkStatusModel: args.canceledNetworkStatusModel,
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(
          orElse: () => const LoadingRouteArgs());
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: _i6.LoadingPage(
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i7.DashboardPage(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i8.ValidatorsPage(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: const _i9.MyAccountPage(),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxTokensSendFormRoute.name: (routeData) {
      final args = routeData.argsAs<TxTokensSendFormRouteArgs>(
          orElse: () => const TxTokensSendFormRouteArgs());
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: _i10.TxTokensSendFormPage(
          initialBalanceModel: args.initialBalanceModel,
          key: args.key,
        ),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxConfirmRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TxConfirmRouteArgs>(
          orElse: () => TxConfirmRouteArgs(
            txFormPageName: queryParams.optString('txFormPageName'),
                signedTxModel: queryParams.get('tx'),
                tokenDenominationModel: queryParams.get('denom'),
              ));
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: _i11.TxConfirmPage(
          txFormPageName: args.txFormPageName,
          signedTxModel: args.signedTxModel,
          tokenDenominationModel: args.tokenDenominationModel,
          key: args.key,
        ),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxBroadcastRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TxBroadcastRouteArgs>(
          orElse: () => TxBroadcastRouteArgs(
                txFormPageName: queryParams.optString('txFormPageName'),
                signedTxModel: queryParams.get('tx'),
              ));
      return _i13.CustomPage<void>(
        routeData: routeData,
        child: _i12.TxBroadcastPage(
          txFormPageName: args.txFormPageName,
          signedTxModel: args.signedTxModel,
          key: args.key,
        ),
        transitionsBuilder: _i13.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          PagesWrapperRoute.name,
          path: '/',
          guards: [connectionGuard],
          children: [
            _i13.RouteConfig(
              '#redirect',
              path: '',
              parent: PagesWrapperRoute.name,
              redirectTo: 'network',
              fullMatch: true,
            ),
            _i13.RouteConfig(
              LoadingWrapperRoute.name,
              path: 'network',
              parent: PagesWrapperRoute.name,
              children: [
                _i13.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: LoadingWrapperRoute.name,
                  redirectTo: 'list',
                  fullMatch: true,
                ),
                _i13.RouteConfig(
                  NetworkListRoute.name,
                  path: 'list',
                  parent: LoadingWrapperRoute.name,
                ),
                _i13.RouteConfig(
                  LoadingRoute.name,
                  path: 'loading',
                  parent: LoadingWrapperRoute.name,
                  guards: [loadingPageGuard],
                ),
              ],
            ),
            _i13.RouteConfig(
              MenuWrapperRoute.name,
              path: 'app',
              parent: PagesWrapperRoute.name,
              children: [
                _i13.RouteConfig(
                  DashboardRoute.name,
                  path: 'dashboard',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i13.RouteConfig(
                  ValidatorsRoute.name,
                  path: 'validators',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i13.RouteConfig(
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
            _i13.RouteConfig(
              TransactionsWrapperRoute.name,
              path: 'transactions',
              parent: PagesWrapperRoute.name,
              guards: [authGuard],
              children: [
                _i13.RouteConfig(
                  TxTokensSendFormRoute.name,
                  path: 'tokens/send',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
                _i13.RouteConfig(
                  TxConfirmRoute.name,
                  path: 'transaction/confirm',
                  parent: TransactionsWrapperRoute.name,
                  guards: [
                    authGuard,
                    txConfirmPageGuard,
                  ],
                ),
                _i13.RouteConfig(
                  TxBroadcastRoute.name,
                  path: 'transaction/broadcast',
                  parent: TransactionsWrapperRoute.name,
                  guards: [
                    authGuard,
                    txBroadcastPageGuard,
                  ],
                ),
              ],
            ),
          ],
        ),
        _i13.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesWrapperRoute extends _i13.PageRouteInfo<void> {
  const PagesWrapperRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PagesWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'PagesWrapperRoute';
}

/// generated route for
/// [_i2.LoadingWrapper]
class LoadingWrapperRoute extends _i13.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoadingWrapperRoute.name,
          path: 'network',
          initialChildren: children,
        );

  static const String name = 'LoadingWrapperRoute';
}

/// generated route for
/// [_i3.MenuWrapper]
class MenuWrapperRoute extends _i13.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          path: 'app',
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';
}

/// generated route for
/// [_i4.TransactionsWrapper]
class TransactionsWrapperRoute extends _i13.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i13.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          path: 'transactions',
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i5.NetworkListPage]
class NetworkListRoute extends _i13.PageRouteInfo<NetworkListRouteArgs> {
  NetworkListRoute({
    _i21.ConnectionErrorType connectionErrorType = _i21.ConnectionErrorType.canceledByUser,
    _i22.ANetworkStatusModel? canceledNetworkStatusModel,
    _i13.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i14.Key? key,
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
    this.connectionErrorType = _i21.ConnectionErrorType.canceledByUser,
    this.canceledNetworkStatusModel,
    this.nextPageRouteInfo,
    this.key,
  });

  final _i21.ConnectionErrorType connectionErrorType;

  final _i22.ANetworkStatusModel? canceledNetworkStatusModel;

  final _i13.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i14.Key? key;

  @override
  String toString() {
    return 'NetworkListRouteArgs{connectionErrorType: $connectionErrorType, canceledNetworkStatusModel: $canceledNetworkStatusModel, nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i6.LoadingPage]
class LoadingRoute extends _i13.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    _i13.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i14.Key? key,
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

  final _i13.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i14.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i7.DashboardPage]
class DashboardRoute extends _i13.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i8.ValidatorsPage]
class ValidatorsRoute extends _i13.PageRouteInfo<void> {
  const ValidatorsRoute()
      : super(
          ValidatorsRoute.name,
          path: 'validators',
        );

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i9.MyAccountPage]
class MyAccountRoute extends _i13.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(
          MyAccountRoute.name,
          path: 'my-account',
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i10.TxTokensSendFormPage]
class TxTokensSendFormRoute extends _i13.PageRouteInfo<TxTokensSendFormRouteArgs> {
  TxTokensSendFormRoute({
    _i23.BalanceModel? initialBalanceModel,
    _i14.Key? key,
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

  final _i23.BalanceModel? initialBalanceModel;

  final _i14.Key? key;

  @override
  String toString() {
    return 'TxTokensSendFormRouteArgs{initialBalanceModel: $initialBalanceModel, key: $key}';
  }
}

/// generated route for
/// [_i11.TxConfirmPage]
class TxConfirmRoute extends _i13.PageRouteInfo<TxConfirmRouteArgs> {
  TxConfirmRoute({
    String? txFormPageName,
    _i24.SignedTxModel? signedTxModel,
    _i25.TokenDenominationModel? tokenDenominationModel,
    _i14.Key? key,
  }) : super(
          TxConfirmRoute.name,
          path: 'transaction/confirm',
          args: TxConfirmRouteArgs(
            txFormPageName: txFormPageName,
            signedTxModel: signedTxModel,
            tokenDenominationModel: tokenDenominationModel,
            key: key,
          ),
          rawQueryParams: {
            'txFormPageName': txFormPageName,
            'tx': signedTxModel,
            'denom': tokenDenominationModel,
          },
        );

  static const String name = 'TxConfirmRoute';
}

class TxConfirmRouteArgs {
  const TxConfirmRouteArgs({
    this.txFormPageName,
    this.signedTxModel,
    this.tokenDenominationModel,
    this.key,
  });

  final String? txFormPageName;

  final _i24.SignedTxModel? signedTxModel;

  final _i25.TokenDenominationModel? tokenDenominationModel;

  final _i14.Key? key;

  @override
  String toString() {
    return 'TxConfirmRouteArgs{txFormPageName: $txFormPageName, signedTxModel: $signedTxModel, tokenDenominationModel: $tokenDenominationModel, key: $key}';
  }
}

/// generated route for
/// [_i12.TxBroadcastPage]
class TxBroadcastRoute extends _i13.PageRouteInfo<TxBroadcastRouteArgs> {
  TxBroadcastRoute({
    String? txFormPageName,
    _i24.SignedTxModel? signedTxModel,
    _i14.Key? key,
  }) : super(
    TxBroadcastRoute.name,
          path: 'transaction/broadcast',
          args: TxBroadcastRouteArgs(
            txFormPageName: txFormPageName,
            signedTxModel: signedTxModel,
            key: key,
          ),
          rawQueryParams: {
            'txFormPageName': txFormPageName,
            'tx': signedTxModel,
          },
        );

  static const String name = 'TxBroadcastRoute';
}

class TxBroadcastRouteArgs {
  const TxBroadcastRouteArgs({
    this.txFormPageName,
    this.signedTxModel,
    this.key,
  });

  final String? txFormPageName;

  final _i24.SignedTxModel? signedTxModel;

  final _i14.Key? key;

  @override
  String toString() {
    return 'TxBroadcastRouteArgs{txFormPageName: $txFormPageName, signedTxModel: $signedTxModel, key: $key}';
  }
}
