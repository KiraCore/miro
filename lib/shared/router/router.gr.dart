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
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;

import '../../views/pages/loading/loading_page/loading_page.dart' as _i6;
import '../../views/pages/loading/loading_wrapper.dart' as _i2;
import '../../views/pages/loading/network_list_page/network_list_page.dart'
    as _i5;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i7;
import '../../views/pages/menu/menu_wrapper.dart' as _i3;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i9;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i8;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../../views/pages/transactions/transactions_wrapper.dart' as _i4;
import '../../views/pages/transactions/tx_send/ir_tx_delete_record_page/ir_tx_delete_record_page.dart'
    as _i12;
import '../../views/pages/transactions/tx_send/ir_tx_handle_verification_request_page/ir_tx_handle_verification_request_page.dart'
    as _i14;
import '../../views/pages/transactions/tx_send/ir_tx_register_record_page/ir_tx_register_record_page.dart'
    as _i11;
import '../../views/pages/transactions/tx_send/ir_tx_request_verification_page/ir_tx_request_verification_page.dart'
    as _i13;
import '../../views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_page.dart'
    as _i10;
import '../models/balances/balance_model.dart' as _i23;
import '../models/identity_registrar/ir_inbound_verification_request_model.dart'
    as _i25;
import '../models/identity_registrar/ir_record_model.dart' as _i24;
import '../models/network/connection/connection_error_type.dart' as _i21;
import '../models/network/status/a_network_status_model.dart' as _i22;
import 'guards/auth_guard.dart' as _i18;
import 'guards/connection_guard.dart' as _i17;
import 'guards/navigation_guard.dart' as _i20;
import 'guards/pages/loading_page_guard.dart' as _i19;

class AppRouter extends _i15.RootStackRouter {
  AppRouter({
    _i16.GlobalKey<_i16.NavigatorState>? navigatorKey,
    required this.connectionGuard,
    required this.authGuard,
    required this.loadingPageGuard,
    required this.navigationGuard,
  }) : super(navigatorKey);

  final _i17.ConnectionGuard connectionGuard;

  final _i18.AuthGuard authGuard;

  final _i19.LoadingPageGuard loadingPageGuard;

  final _i20.NavigationGuard navigationGuard;

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    PagesWrapperRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i1.PagesWrapper(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingWrapperRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i2.LoadingWrapper(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i3.MenuWrapper(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 1000,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i4.TransactionsWrapper(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NetworkListRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkListRouteArgs>(
          orElse: () => const NetworkListRouteArgs());
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i5.NetworkListPage(
          connectionErrorType: args.connectionErrorType,
          canceledNetworkStatusModel: args.canceledNetworkStatusModel,
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(
          orElse: () => const LoadingRouteArgs());
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i6.LoadingPage(
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DashboardRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i7.DashboardPage(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i8.ValidatorsPage(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: const _i9.MyAccountPage(),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    TxSendTokensRoute.name: (routeData) {
      final args = routeData.argsAs<TxSendTokensRouteArgs>(
          orElse: () => const TxSendTokensRouteArgs());
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i10.TxSendTokensPage(
          defaultBalanceModel: args.defaultBalanceModel,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    IRTxRegisterRecordRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxRegisterRecordRouteArgs>();
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i11.IRTxRegisterRecordPage(
          irKeyEditableBool: args.irKeyEditableBool,
          irRecordModel: args.irRecordModel,
          irValueMaxLength: args.irValueMaxLength,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    IRTxDeleteRecordRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxDeleteRecordRouteArgs>();
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i12.IRTxDeleteRecordPage(
          irRecordModel: args.irRecordModel,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    IRTxRequestVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxRequestVerificationRouteArgs>();
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i13.IRTxRequestVerificationPage(
          irRecordModel: args.irRecordModel,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    IRTxHandleVerificationRequestRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxHandleVerificationRequestRouteArgs>();
      return _i15.CustomPage<void>(
        routeData: routeData,
        child: _i14.IRTxHandleVerificationRequestPage(
          approvalStatusBool: args.approvalStatusBool,
          irInboundVerificationRequestModel:
              args.irInboundVerificationRequestModel,
          key: args.key,
        ),
        transitionsBuilder: _i15.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i15.RouteConfig> get routes => [
        _i15.RouteConfig(
          PagesWrapperRoute.name,
          path: '/',
          guards: [connectionGuard],
          children: [
            _i15.RouteConfig(
              '#redirect',
              path: '',
              parent: PagesWrapperRoute.name,
              redirectTo: 'network',
              fullMatch: true,
            ),
            _i15.RouteConfig(
              LoadingWrapperRoute.name,
              path: 'network',
              parent: PagesWrapperRoute.name,
              children: [
                _i15.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: LoadingWrapperRoute.name,
                  redirectTo: 'list',
                  fullMatch: true,
                ),
                _i15.RouteConfig(
                  NetworkListRoute.name,
                  path: 'list',
                  parent: LoadingWrapperRoute.name,
                ),
                _i15.RouteConfig(
                  LoadingRoute.name,
                  path: 'loading',
                  parent: LoadingWrapperRoute.name,
                  guards: [loadingPageGuard],
                ),
              ],
            ),
            _i15.RouteConfig(
              MenuWrapperRoute.name,
              path: 'app',
              parent: PagesWrapperRoute.name,
              children: [
                _i15.RouteConfig(
                  DashboardRoute.name,
                  path: 'dashboard',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i15.RouteConfig(
                  ValidatorsRoute.name,
                  path: 'validators',
                  parent: MenuWrapperRoute.name,
                  guards: [navigationGuard],
                ),
                _i15.RouteConfig(
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
            _i15.RouteConfig(
              TransactionsWrapperRoute.name,
              path: 'transactions',
              parent: PagesWrapperRoute.name,
              guards: [authGuard],
              children: [
                _i15.RouteConfig(
                  TxSendTokensRoute.name,
                  path: 'tokens/send',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
                _i15.RouteConfig(
                  IRTxRegisterRecordRoute.name,
                  path: 'identity/register',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
                _i15.RouteConfig(
                  IRTxDeleteRecordRoute.name,
                  path: 'identity/delete',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
                _i15.RouteConfig(
                  IRTxRequestVerificationRoute.name,
                  path: 'identity/verify',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
                _i15.RouteConfig(
                  IRTxHandleVerificationRequestRoute.name,
                  path: 'identity/handle-verification-request',
                  parent: TransactionsWrapperRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
          ],
        ),
        _i15.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.PagesWrapper]
class PagesWrapperRoute extends _i15.PageRouteInfo<void> {
  const PagesWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          PagesWrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'PagesWrapperRoute';
}

/// generated route for
/// [_i2.LoadingWrapper]
class LoadingWrapperRoute extends _i15.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoadingWrapperRoute.name,
          path: 'network',
          initialChildren: children,
        );

  static const String name = 'LoadingWrapperRoute';
}

/// generated route for
/// [_i3.MenuWrapper]
class MenuWrapperRoute extends _i15.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          path: 'app',
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';
}

/// generated route for
/// [_i4.TransactionsWrapper]
class TransactionsWrapperRoute extends _i15.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i15.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          path: 'transactions',
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';
}

/// generated route for
/// [_i5.NetworkListPage]
class NetworkListRoute extends _i15.PageRouteInfo<NetworkListRouteArgs> {
  NetworkListRoute({
    _i21.ConnectionErrorType connectionErrorType =
        _i21.ConnectionErrorType.canceledByUser,
    _i22.ANetworkStatusModel? canceledNetworkStatusModel,
    _i15.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i16.Key? key,
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

  final _i15.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i16.Key? key;

  @override
  String toString() {
    return 'NetworkListRouteArgs{connectionErrorType: $connectionErrorType, canceledNetworkStatusModel: $canceledNetworkStatusModel, nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i6.LoadingPage]
class LoadingRoute extends _i15.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    _i15.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i16.Key? key,
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

  final _i15.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i7.DashboardPage]
class DashboardRoute extends _i15.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: 'dashboard',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i8.ValidatorsPage]
class ValidatorsRoute extends _i15.PageRouteInfo<void> {
  const ValidatorsRoute()
      : super(
          ValidatorsRoute.name,
          path: 'validators',
        );

  static const String name = 'ValidatorsRoute';
}

/// generated route for
/// [_i9.MyAccountPage]
class MyAccountRoute extends _i15.PageRouteInfo<void> {
  const MyAccountRoute()
      : super(
          MyAccountRoute.name,
          path: 'my-account',
        );

  static const String name = 'MyAccountRoute';
}

/// generated route for
/// [_i10.TxSendTokensPage]
class TxSendTokensRoute extends _i15.PageRouteInfo<TxSendTokensRouteArgs> {
  TxSendTokensRoute({
    _i23.BalanceModel? defaultBalanceModel,
    _i16.Key? key,
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

  final _i23.BalanceModel? defaultBalanceModel;

  final _i16.Key? key;

  @override
  String toString() {
    return 'TxSendTokensRouteArgs{defaultBalanceModel: $defaultBalanceModel, key: $key}';
  }
}

/// generated route for
/// [_i11.IRTxRegisterRecordPage]
class IRTxRegisterRecordRoute
    extends _i15.PageRouteInfo<IRTxRegisterRecordRouteArgs> {
  IRTxRegisterRecordRoute({
    required bool irKeyEditableBool,
    required _i24.IRRecordModel? irRecordModel,
    int? irValueMaxLength,
    _i16.Key? key,
  }) : super(
          IRTxRegisterRecordRoute.name,
          path: 'identity/register',
          args: IRTxRegisterRecordRouteArgs(
            irKeyEditableBool: irKeyEditableBool,
            irRecordModel: irRecordModel,
            irValueMaxLength: irValueMaxLength,
            key: key,
          ),
        );

  static const String name = 'IRTxRegisterRecordRoute';
}

class IRTxRegisterRecordRouteArgs {
  const IRTxRegisterRecordRouteArgs({
    required this.irKeyEditableBool,
    required this.irRecordModel,
    this.irValueMaxLength,
    this.key,
  });

  final bool irKeyEditableBool;

  final _i24.IRRecordModel? irRecordModel;

  final int? irValueMaxLength;

  final _i16.Key? key;

  @override
  String toString() {
    return 'IRTxRegisterRecordRouteArgs{irKeyEditableBool: $irKeyEditableBool, irRecordModel: $irRecordModel, irValueMaxLength: $irValueMaxLength, key: $key}';
  }
}

/// generated route for
/// [_i12.IRTxDeleteRecordPage]
class IRTxDeleteRecordRoute
    extends _i15.PageRouteInfo<IRTxDeleteRecordRouteArgs> {
  IRTxDeleteRecordRoute({
    required _i24.IRRecordModel irRecordModel,
    _i16.Key? key,
  }) : super(
          IRTxDeleteRecordRoute.name,
          path: 'identity/delete',
          args: IRTxDeleteRecordRouteArgs(
            irRecordModel: irRecordModel,
            key: key,
          ),
        );

  static const String name = 'IRTxDeleteRecordRoute';
}

class IRTxDeleteRecordRouteArgs {
  const IRTxDeleteRecordRouteArgs({
    required this.irRecordModel,
    this.key,
  });

  final _i24.IRRecordModel irRecordModel;

  final _i16.Key? key;

  @override
  String toString() {
    return 'IRTxDeleteRecordRouteArgs{irRecordModel: $irRecordModel, key: $key}';
  }
}

/// generated route for
/// [_i13.IRTxRequestVerificationPage]
class IRTxRequestVerificationRoute
    extends _i15.PageRouteInfo<IRTxRequestVerificationRouteArgs> {
  IRTxRequestVerificationRoute({
    required _i24.IRRecordModel irRecordModel,
    _i16.Key? key,
  }) : super(
          IRTxRequestVerificationRoute.name,
          path: 'identity/verify',
          args: IRTxRequestVerificationRouteArgs(
            irRecordModel: irRecordModel,
            key: key,
          ),
        );

  static const String name = 'IRTxRequestVerificationRoute';
}

class IRTxRequestVerificationRouteArgs {
  const IRTxRequestVerificationRouteArgs({
    required this.irRecordModel,
    this.key,
  });

  final _i24.IRRecordModel irRecordModel;

  final _i16.Key? key;

  @override
  String toString() {
    return 'IRTxRequestVerificationRouteArgs{irRecordModel: $irRecordModel, key: $key}';
  }
}

/// generated route for
/// [_i14.IRTxHandleVerificationRequestPage]
class IRTxHandleVerificationRequestRoute
    extends _i15.PageRouteInfo<IRTxHandleVerificationRequestRouteArgs> {
  IRTxHandleVerificationRequestRoute({
    required bool approvalStatusBool,
    required _i25.IRInboundVerificationRequestModel
        irInboundVerificationRequestModel,
    _i16.Key? key,
  }) : super(
          IRTxHandleVerificationRequestRoute.name,
          path: 'identity/handle-verification-request',
          args: IRTxHandleVerificationRequestRouteArgs(
            approvalStatusBool: approvalStatusBool,
            irInboundVerificationRequestModel:
                irInboundVerificationRequestModel,
            key: key,
          ),
        );

  static const String name = 'IRTxHandleVerificationRequestRoute';
}

class IRTxHandleVerificationRequestRouteArgs {
  const IRTxHandleVerificationRequestRouteArgs({
    required this.approvalStatusBool,
    required this.irInboundVerificationRequestModel,
    this.key,
  });

  final bool approvalStatusBool;

  final _i25.IRInboundVerificationRequestModel
      irInboundVerificationRequestModel;

  final _i16.Key? key;

  @override
  String toString() {
    return 'IRTxHandleVerificationRequestRouteArgs{approvalStatusBool: $approvalStatusBool, irInboundVerificationRequestModel: $irInboundVerificationRequestModel, key: $key}';
  }
}
