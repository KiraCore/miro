// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/cupertino.dart' as _i20;
import 'package:flutter/material.dart' as _i15;

import '../../infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart' as _i23;
import '../../infra/dto/api_cosmos/broadcast/request/transaction/transaction_sign_request.dart' as _i22;
import '../../infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart' as _i21;
import '../../views/pages/dialog/dialog_wrapper.dart' as _i2;
import '../../views/pages/dialog/transaction_create_page/transaction_create_page.dart' as _i9;
import '../../views/pages/dialog/transaction_request_page/transaction_request_page.dart' as _i7;
import '../../views/pages/dialog/transaction_request_page/transaction_request_result_page.dart' as _i8;
import '../../views/pages/dialog/transaction_sign/transaction_broadcast_page.dart' as _i13;
import '../../views/pages/dialog/transaction_sign/transaction_confirm_page.dart' as _i12;
import '../../views/pages/dialog/transaction_sign/transaction_scan_page.dart' as _i11;
import '../../views/pages/dialog/transaction_sign/transaction_sign_with_saifu_page.dart' as _i10;
import '../../views/pages/menu/accounts_page/accounts_page.dart' as _i3;
import '../../views/pages/menu/dashboard_page/dashboard_page.dart' as _i4;
import '../../views/pages/menu/my_account_page/my_account_page.dart' as _i6;
import '../../views/pages/menu/validators_page/validators_page.dart' as _i5;
import '../../views/pages/pages_wrapper.dart' as _i1;
import '../guards/auth_guard.dart' as _i18;
import '../guards/empty_params_guard.dart' as _i19;
import '../guards/navigation_guard.dart' as _i17;
import '../guards/url_parameters_guard.dart' as _i16;

class AppRouter extends _i14.RootStackRouter {
  AppRouter(
      {_i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
      required this.urlParametersGuard,
      required this.navigationGuard,
      required this.authGuard,
      required this.emptyParamsGuard})
      : super(navigatorKey);

  final _i16.UrlParametersGuard urlParametersGuard;

  final _i17.NavigationGuard navigationGuard;

  final _i18.AuthGuard authGuard;

  final _i19.EmptyParamsGuard emptyParamsGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    PagesRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData, child: const _i1.PagesWrapper(), opaque: true, barrierDismissible: false);
    },
    DialogWrapperRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i2.DialogWrapper(),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    AccountsRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i3.AccountsPage(),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    DashboardRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i4.DashboardPage(),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    ValidatorsRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i5.ValidatorsPage(),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    MyAccountRoute.name: (routeData) {
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: const _i6.MyAccountPage(),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionRequestRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TransactionRequestRouteArgs>(
          orElse: () => TransactionRequestRouteArgs(messageType: queryParams.getString('messageType', 'MsgSend')));
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i7.TransactionRequestPage(messageType: args.messageType, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionRequestResultRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionRequestResultRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i8.TransactionRequestResultPage(unsignedTransaction: args.unsignedTransaction, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionCreateRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<TransactionCreateRouteArgs>(
          orElse: () => TransactionCreateRouteArgs(
              messageType: queryParams.getString('messageType', 'MsgSend'), metadata: queryParams.get('metadata')));
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i9.TransactionCreatePage(messageType: args.messageType, metadata: args.metadata, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionSignWithSaifuRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionSignWithSaifuRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i10.TransactionSignWithSaifuPage(unsignedTransaction: args.unsignedTransaction, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionScanRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionScanRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i11.TransactionScanPage(transactionSignRequest: args.transactionSignRequest, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionConfirmRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionConfirmRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i12.TransactionConfirmPage(signedTransaction: args.signedTransaction, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    },
    TransactionBroadcastRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionBroadcastRouteArgs>();
      return _i14.CustomPage<void>(
          routeData: routeData,
          child: _i13.TransactionBroadcastPage(signedTransaction: args.signedTransaction, key: args.key),
          transitionsBuilder: _i14.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 500,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(PagesRoute.name, path: '/', guards: [
          urlParametersGuard
        ], children: [
          _i14.RouteConfig(AccountsRoute.name,
              path: 'accounts', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i14.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i14.RouteConfig(ValidatorsRoute.name,
              path: 'validators', parent: PagesRoute.name, guards: [urlParametersGuard, navigationGuard]),
          _i14.RouteConfig(MyAccountRoute.name,
              path: 'my-account', parent: PagesRoute.name, guards: [authGuard, urlParametersGuard, navigationGuard]),
          _i14.RouteConfig('*#redirect', path: '*', parent: PagesRoute.name, redirectTo: 'dashboard', fullMatch: true)
        ]),
        _i14.RouteConfig(DialogWrapperRoute.name, path: '/d', children: [
          _i14.RouteConfig(TransactionRequestRoute.name,
              path: 'transaction/request', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionRequestResultRoute.name,
              path: 'transaction/request/result', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionCreateRoute.name,
              path: 'transaction/create', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionSignWithSaifuRoute.name,
              path: 'transaction/saifu/sign', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionScanRoute.name,
              path: 'transaction/saifu/scan', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionConfirmRoute.name,
              path: 'transaction/confirm', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig(TransactionBroadcastRoute.name,
              path: 'transaction/broadcast', parent: DialogWrapperRoute.name, guards: [emptyParamsGuard]),
          _i14.RouteConfig('*#redirect', path: '*', parent: DialogWrapperRoute.name, redirectTo: '/', fullMatch: true)
        ]),
        _i14.RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [_i1.PagesWrapper]
class PagesRoute extends _i14.PageRouteInfo<void> {
  const PagesRoute({List<_i14.PageRouteInfo>? children}) : super(name, path: '/', initialChildren: children);

  static const String name = 'PagesRoute';
}

/// generated route for [_i2.DialogWrapper]
class DialogWrapperRoute extends _i14.PageRouteInfo<void> {
  const DialogWrapperRoute({List<_i14.PageRouteInfo>? children}) : super(name, path: '/d', initialChildren: children);

  static const String name = 'DialogWrapperRoute';
}

/// generated route for [_i3.AccountsPage]
class AccountsRoute extends _i14.PageRouteInfo<void> {
  const AccountsRoute() : super(name, path: 'accounts');

  static const String name = 'AccountsRoute';
}

/// generated route for [_i4.DashboardPage]
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute() : super(name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for [_i5.ValidatorsPage]
class ValidatorsRoute extends _i14.PageRouteInfo<void> {
  const ValidatorsRoute() : super(name, path: 'validators');

  static const String name = 'ValidatorsRoute';
}

/// generated route for [_i6.MyAccountPage]
class MyAccountRoute extends _i14.PageRouteInfo<void> {
  const MyAccountRoute() : super(name, path: 'my-account');

  static const String name = 'MyAccountRoute';
}

/// generated route for [_i7.TransactionRequestPage]
class TransactionRequestRoute extends _i14.PageRouteInfo<TransactionRequestRouteArgs> {
  TransactionRequestRoute({String messageType = 'MsgSend', _i20.Key? key})
      : super(name,
            path: 'transaction/request',
            args: TransactionRequestRouteArgs(messageType: messageType, key: key),
            rawQueryParams: {'messageType': messageType});

  static const String name = 'TransactionRequestRoute';
}

class TransactionRequestRouteArgs {
  const TransactionRequestRouteArgs({this.messageType = 'MsgSend', this.key});

  final String messageType;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionRequestRouteArgs{messageType: $messageType, key: $key}';
  }
}

/// generated route for [_i8.TransactionRequestResultPage]
class TransactionRequestResultRoute extends _i14.PageRouteInfo<TransactionRequestResultRouteArgs> {
  TransactionRequestResultRoute({required _i21.UnsignedTransaction unsignedTransaction, _i20.Key? key})
      : super(name,
            path: 'transaction/request/result',
            args: TransactionRequestResultRouteArgs(unsignedTransaction: unsignedTransaction, key: key));

  static const String name = 'TransactionRequestResultRoute';
}

class TransactionRequestResultRouteArgs {
  const TransactionRequestResultRouteArgs({required this.unsignedTransaction, this.key});

  final _i21.UnsignedTransaction unsignedTransaction;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionRequestResultRouteArgs{unsignedTransaction: $unsignedTransaction, key: $key}';
  }
}

/// generated route for [_i9.TransactionCreatePage]
class TransactionCreateRoute extends _i14.PageRouteInfo<TransactionCreateRouteArgs> {
  TransactionCreateRoute({String messageType = 'MsgSend', Map<String, dynamic>? metadata, _i20.Key? key})
      : super(name,
            path: 'transaction/create',
            args: TransactionCreateRouteArgs(messageType: messageType, metadata: metadata, key: key),
            rawQueryParams: {'messageType': messageType, 'metadata': metadata});

  static const String name = 'TransactionCreateRoute';
}

class TransactionCreateRouteArgs {
  const TransactionCreateRouteArgs({this.messageType = 'MsgSend', this.metadata, this.key});

  final String messageType;

  final Map<String, dynamic>? metadata;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionCreateRouteArgs{messageType: $messageType, metadata: $metadata, key: $key}';
  }
}

/// generated route for [_i10.TransactionSignWithSaifuPage]
class TransactionSignWithSaifuRoute extends _i14.PageRouteInfo<TransactionSignWithSaifuRouteArgs> {
  TransactionSignWithSaifuRoute({required _i21.UnsignedTransaction unsignedTransaction, _i20.Key? key})
      : super(name,
            path: 'transaction/saifu/sign',
            args: TransactionSignWithSaifuRouteArgs(unsignedTransaction: unsignedTransaction, key: key));

  static const String name = 'TransactionSignWithSaifuRoute';
}

class TransactionSignWithSaifuRouteArgs {
  const TransactionSignWithSaifuRouteArgs({required this.unsignedTransaction, this.key});

  final _i21.UnsignedTransaction unsignedTransaction;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionSignWithSaifuRouteArgs{unsignedTransaction: $unsignedTransaction, key: $key}';
  }
}

/// generated route for [_i11.TransactionScanPage]
class TransactionScanRoute extends _i14.PageRouteInfo<TransactionScanRouteArgs> {
  TransactionScanRoute({required _i22.TransactionSignRequest transactionSignRequest, _i20.Key? key})
      : super(name,
            path: 'transaction/saifu/scan',
            args: TransactionScanRouteArgs(transactionSignRequest: transactionSignRequest, key: key));

  static const String name = 'TransactionScanRoute';
}

class TransactionScanRouteArgs {
  const TransactionScanRouteArgs({required this.transactionSignRequest, this.key});

  final _i22.TransactionSignRequest transactionSignRequest;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionScanRouteArgs{transactionSignRequest: $transactionSignRequest, key: $key}';
  }
}

/// generated route for [_i12.TransactionConfirmPage]
class TransactionConfirmRoute extends _i14.PageRouteInfo<TransactionConfirmRouteArgs> {
  TransactionConfirmRoute({required _i23.SignedTransaction signedTransaction, _i20.Key? key})
      : super(name,
            path: 'transaction/confirm',
            args: TransactionConfirmRouteArgs(signedTransaction: signedTransaction, key: key));

  static const String name = 'TransactionConfirmRoute';
}

class TransactionConfirmRouteArgs {
  const TransactionConfirmRouteArgs({required this.signedTransaction, this.key});

  final _i23.SignedTransaction signedTransaction;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionConfirmRouteArgs{signedTransaction: $signedTransaction, key: $key}';
  }
}

/// generated route for [_i13.TransactionBroadcastPage]
class TransactionBroadcastRoute extends _i14.PageRouteInfo<TransactionBroadcastRouteArgs> {
  TransactionBroadcastRoute({required _i23.SignedTransaction signedTransaction, _i20.Key? key})
      : super(name,
            path: 'transaction/broadcast',
            args: TransactionBroadcastRouteArgs(signedTransaction: signedTransaction, key: key));

  static const String name = 'TransactionBroadcastRoute';
}

class TransactionBroadcastRouteArgs {
  const TransactionBroadcastRouteArgs({required this.signedTransaction, this.key});

  final _i23.SignedTransaction signedTransaction;

  final _i20.Key? key;

  @override
  String toString() {
    return 'TransactionBroadcastRouteArgs{signedTransaction: $signedTransaction, key: $key}';
  }
}
