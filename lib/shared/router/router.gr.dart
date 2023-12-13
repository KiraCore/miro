// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/cupertino.dart' as _i19;
import 'package:flutter/material.dart' as _i21;
import 'package:miro/shared/models/balances/balance_model.dart' as _i26;
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart'
    as _i20;
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart'
    as _i18;
import 'package:miro/shared/models/network/connection/connection_error_type.dart'
    as _i22;
import 'package:miro/shared/models/network/status/a_network_status_model.dart'
    as _i23;
import 'package:miro/shared/models/tokens/token_alias_model.dart' as _i24;
import 'package:miro/shared/models/validators/validator_simplified_model.dart'
    as _i25;
import 'package:miro/views/pages/loading/loading_page/loading_page.dart' as _i6;
import 'package:miro/views/pages/loading/loading_wrapper.dart' as _i7;
import 'package:miro/views/pages/loading/network_list_page/network_list_page.dart'
    as _i10;
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart'
    as _i1;
import 'package:miro/views/pages/menu/menu_wrapper.dart' as _i8;
import 'package:miro/views/pages/menu/my_account_page/my_account_page.dart'
    as _i9;
import 'package:miro/views/pages/menu/validators_page/validators_page.dart'
    as _i16;
import 'package:miro/views/pages/transactions/transactions_wrapper.dart'
    as _i14;
import 'package:miro/views/pages/transactions/tx_send/ir_tx_delete_record_page/ir_tx_delete_record_page.dart'
    as _i2;
import 'package:miro/views/pages/transactions/tx_send/ir_tx_handle_verification_request_page/ir_tx_handle_verification_request_page.dart'
    as _i3;
import 'package:miro/views/pages/transactions/tx_send/ir_tx_register_record_page/ir_tx_register_record_page.dart'
    as _i4;
import 'package:miro/views/pages/transactions/tx_send/ir_tx_request_verification_page/ir_tx_request_verification_page.dart'
    as _i5;
import 'package:miro/views/pages/transactions/tx_send/staking_tx_claim_rewards_page/staking_tx_claim_rewards_page.dart'
    as _i11;
import 'package:miro/views/pages/transactions/tx_send/staking_tx_delegate_page/staking_tx_delegate_page.dart'
    as _i12;
import 'package:miro/views/pages/transactions/tx_send/staking_tx_undelegate_page/staking_tx_undelegate_page.dart'
    as _i13;
import 'package:miro/views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_page.dart'
    as _i15;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    DashboardRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    IRTxDeleteRecordRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxDeleteRecordRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.IRTxDeleteRecordPage(
          irRecordModel: args.irRecordModel,
          key: args.key,
        ),
      );
    },
    IRTxHandleVerificationRequestRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxHandleVerificationRequestRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.IRTxHandleVerificationRequestPage(
          approvalStatusBool: args.approvalStatusBool,
          irInboundVerificationRequestModel:
              args.irInboundVerificationRequestModel,
          key: args.key,
        ),
      );
    },
    IRTxRegisterRecordRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxRegisterRecordRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.IRTxRegisterRecordPage(
          irKeyEditableBool: args.irKeyEditableBool,
          irRecordModel: args.irRecordModel,
          irValueMaxLength: args.irValueMaxLength,
          key: args.key,
        ),
      );
    },
    IRTxRequestVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<IRTxRequestVerificationRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.IRTxRequestVerificationPage(
          irRecordModel: args.irRecordModel,
          key: args.key,
        ),
      );
    },
    LoadingRoute.name: (routeData) {
      final args = routeData.argsAs<LoadingRouteArgs>(
          orElse: () => const LoadingRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LoadingPage(
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
      );
    },
    LoadingWrapperRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoadingWrapper(),
      );
    },
    MenuWrapperRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MenuWrapper(),
      );
    },
    MyAccountRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MyAccountPage(),
      );
    },
    NetworkListRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkListRouteArgs>(
          orElse: () => const NetworkListRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.NetworkListPage(
          connectionErrorType: args.connectionErrorType,
          canceledNetworkStatusModel: args.canceledNetworkStatusModel,
          nextPageRouteInfo: args.nextPageRouteInfo,
          key: args.key,
        ),
      );
    },
    StakingTxClaimRewardsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.StakingTxClaimRewardsPage(),
      );
    },
    StakingTxDelegateRoute.name: (routeData) {
      final args = routeData.argsAs<StakingTxDelegateRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.StakingTxDelegatePage(
          stakeableTokens: args.stakeableTokens,
          validatorSimplifiedModel: args.validatorSimplifiedModel,
          key: args.key,
        ),
      );
    },
    StakingTxUndelegateRoute.name: (routeData) {
      final args = routeData.argsAs<StakingTxUndelegateRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.StakingTxUndelegatePage(
          validatorSimplifiedModel: args.validatorSimplifiedModel,
          key: args.key,
        ),
      );
    },
    TransactionsWrapperRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.TransactionsWrapper(),
      );
    },
    TxSendTokensRoute.name: (routeData) {
      final args = routeData.argsAs<TxSendTokensRouteArgs>(
          orElse: () => const TxSendTokensRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.TxSendTokensPage(
          defaultBalanceModel: args.defaultBalanceModel,
          key: args.key,
        ),
      );
    },
    ValidatorsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.ValidatorsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i17.PageRouteInfo<void> {
  const DashboardRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.IRTxDeleteRecordPage]
class IRTxDeleteRecordRoute
    extends _i17.PageRouteInfo<IRTxDeleteRecordRouteArgs> {
  IRTxDeleteRecordRoute({
    required _i18.IRRecordModel irRecordModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          IRTxDeleteRecordRoute.name,
          args: IRTxDeleteRecordRouteArgs(
            irRecordModel: irRecordModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IRTxDeleteRecordRoute';

  static const _i17.PageInfo<IRTxDeleteRecordRouteArgs> page =
      _i17.PageInfo<IRTxDeleteRecordRouteArgs>(name);
}

class IRTxDeleteRecordRouteArgs {
  const IRTxDeleteRecordRouteArgs({
    required this.irRecordModel,
    this.key,
  });

  final _i18.IRRecordModel irRecordModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'IRTxDeleteRecordRouteArgs{irRecordModel: $irRecordModel, key: $key}';
  }
}

/// generated route for
/// [_i3.IRTxHandleVerificationRequestPage]
class IRTxHandleVerificationRequestRoute
    extends _i17.PageRouteInfo<IRTxHandleVerificationRequestRouteArgs> {
  IRTxHandleVerificationRequestRoute({
    required bool approvalStatusBool,
    required _i20.IRInboundVerificationRequestModel
        irInboundVerificationRequestModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          IRTxHandleVerificationRequestRoute.name,
          args: IRTxHandleVerificationRequestRouteArgs(
            approvalStatusBool: approvalStatusBool,
            irInboundVerificationRequestModel:
                irInboundVerificationRequestModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IRTxHandleVerificationRequestRoute';

  static const _i17.PageInfo<IRTxHandleVerificationRequestRouteArgs> page =
      _i17.PageInfo<IRTxHandleVerificationRequestRouteArgs>(name);
}

class IRTxHandleVerificationRequestRouteArgs {
  const IRTxHandleVerificationRequestRouteArgs({
    required this.approvalStatusBool,
    required this.irInboundVerificationRequestModel,
    this.key,
  });

  final bool approvalStatusBool;

  final _i20.IRInboundVerificationRequestModel
      irInboundVerificationRequestModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'IRTxHandleVerificationRequestRouteArgs{approvalStatusBool: $approvalStatusBool, irInboundVerificationRequestModel: $irInboundVerificationRequestModel, key: $key}';
  }
}

/// generated route for
/// [_i4.IRTxRegisterRecordPage]
class IRTxRegisterRecordRoute
    extends _i17.PageRouteInfo<IRTxRegisterRecordRouteArgs> {
  IRTxRegisterRecordRoute({
    required bool irKeyEditableBool,
    required _i18.IRRecordModel? irRecordModel,
    int? irValueMaxLength,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          IRTxRegisterRecordRoute.name,
          args: IRTxRegisterRecordRouteArgs(
            irKeyEditableBool: irKeyEditableBool,
            irRecordModel: irRecordModel,
            irValueMaxLength: irValueMaxLength,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IRTxRegisterRecordRoute';

  static const _i17.PageInfo<IRTxRegisterRecordRouteArgs> page =
      _i17.PageInfo<IRTxRegisterRecordRouteArgs>(name);
}

class IRTxRegisterRecordRouteArgs {
  const IRTxRegisterRecordRouteArgs({
    required this.irKeyEditableBool,
    required this.irRecordModel,
    this.irValueMaxLength,
    this.key,
  });

  final bool irKeyEditableBool;

  final _i18.IRRecordModel? irRecordModel;

  final int? irValueMaxLength;

  final _i19.Key? key;

  @override
  String toString() {
    return 'IRTxRegisterRecordRouteArgs{irKeyEditableBool: $irKeyEditableBool, irRecordModel: $irRecordModel, irValueMaxLength: $irValueMaxLength, key: $key}';
  }
}

/// generated route for
/// [_i5.IRTxRequestVerificationPage]
class IRTxRequestVerificationRoute
    extends _i17.PageRouteInfo<IRTxRequestVerificationRouteArgs> {
  IRTxRequestVerificationRoute({
    required _i18.IRRecordModel irRecordModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          IRTxRequestVerificationRoute.name,
          args: IRTxRequestVerificationRouteArgs(
            irRecordModel: irRecordModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'IRTxRequestVerificationRoute';

  static const _i17.PageInfo<IRTxRequestVerificationRouteArgs> page =
      _i17.PageInfo<IRTxRequestVerificationRouteArgs>(name);
}

class IRTxRequestVerificationRouteArgs {
  const IRTxRequestVerificationRouteArgs({
    required this.irRecordModel,
    this.key,
  });

  final _i18.IRRecordModel irRecordModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'IRTxRequestVerificationRouteArgs{irRecordModel: $irRecordModel, key: $key}';
  }
}

/// generated route for
/// [_i6.LoadingPage]
class LoadingRoute extends _i17.PageRouteInfo<LoadingRouteArgs> {
  LoadingRoute({
    _i17.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i21.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          LoadingRoute.name,
          args: LoadingRouteArgs(
            nextPageRouteInfo: nextPageRouteInfo,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoadingRoute';

  static const _i17.PageInfo<LoadingRouteArgs> page =
      _i17.PageInfo<LoadingRouteArgs>(name);
}

class LoadingRouteArgs {
  const LoadingRouteArgs({
    this.nextPageRouteInfo,
    this.key,
  });

  final _i17.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i21.Key? key;

  @override
  String toString() {
    return 'LoadingRouteArgs{nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i7.LoadingWrapper]
class LoadingWrapperRoute extends _i17.PageRouteInfo<void> {
  const LoadingWrapperRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LoadingWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoadingWrapperRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.MenuWrapper]
class MenuWrapperRoute extends _i17.PageRouteInfo<void> {
  const MenuWrapperRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MenuWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuWrapperRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MyAccountPage]
class MyAccountRoute extends _i17.PageRouteInfo<void> {
  const MyAccountRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MyAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyAccountRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.NetworkListPage]
class NetworkListRoute extends _i17.PageRouteInfo<NetworkListRouteArgs> {
  NetworkListRoute({
    _i22.ConnectionErrorType connectionErrorType =
        _i22.ConnectionErrorType.canceledByUser,
    _i23.ANetworkStatusModel? canceledNetworkStatusModel,
    _i17.PageRouteInfo<dynamic>? nextPageRouteInfo,
    _i21.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          NetworkListRoute.name,
          args: NetworkListRouteArgs(
            connectionErrorType: connectionErrorType,
            canceledNetworkStatusModel: canceledNetworkStatusModel,
            nextPageRouteInfo: nextPageRouteInfo,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'NetworkListRoute';

  static const _i17.PageInfo<NetworkListRouteArgs> page =
      _i17.PageInfo<NetworkListRouteArgs>(name);
}

class NetworkListRouteArgs {
  const NetworkListRouteArgs({
    this.connectionErrorType = _i22.ConnectionErrorType.canceledByUser,
    this.canceledNetworkStatusModel,
    this.nextPageRouteInfo,
    this.key,
  });

  final _i22.ConnectionErrorType connectionErrorType;

  final _i23.ANetworkStatusModel? canceledNetworkStatusModel;

  final _i17.PageRouteInfo<dynamic>? nextPageRouteInfo;

  final _i21.Key? key;

  @override
  String toString() {
    return 'NetworkListRouteArgs{connectionErrorType: $connectionErrorType, canceledNetworkStatusModel: $canceledNetworkStatusModel, nextPageRouteInfo: $nextPageRouteInfo, key: $key}';
  }
}

/// generated route for
/// [_i11.StakingTxClaimRewardsPage]
class StakingTxClaimRewardsRoute extends _i17.PageRouteInfo<void> {
  const StakingTxClaimRewardsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          StakingTxClaimRewardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StakingTxClaimRewardsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.StakingTxDelegatePage]
class StakingTxDelegateRoute
    extends _i17.PageRouteInfo<StakingTxDelegateRouteArgs> {
  StakingTxDelegateRoute({
    required List<_i24.TokenAliasModel> stakeableTokens,
    required _i25.ValidatorSimplifiedModel validatorSimplifiedModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          StakingTxDelegateRoute.name,
          args: StakingTxDelegateRouteArgs(
            stakeableTokens: stakeableTokens,
            validatorSimplifiedModel: validatorSimplifiedModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'StakingTxDelegateRoute';

  static const _i17.PageInfo<StakingTxDelegateRouteArgs> page =
      _i17.PageInfo<StakingTxDelegateRouteArgs>(name);
}

class StakingTxDelegateRouteArgs {
  const StakingTxDelegateRouteArgs({
    required this.stakeableTokens,
    required this.validatorSimplifiedModel,
    this.key,
  });

  final List<_i24.TokenAliasModel> stakeableTokens;

  final _i25.ValidatorSimplifiedModel validatorSimplifiedModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'StakingTxDelegateRouteArgs{stakeableTokens: $stakeableTokens, validatorSimplifiedModel: $validatorSimplifiedModel, key: $key}';
  }
}

/// generated route for
/// [_i13.StakingTxUndelegatePage]
class StakingTxUndelegateRoute
    extends _i17.PageRouteInfo<StakingTxUndelegateRouteArgs> {
  StakingTxUndelegateRoute({
    required _i25.ValidatorSimplifiedModel validatorSimplifiedModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          StakingTxUndelegateRoute.name,
          args: StakingTxUndelegateRouteArgs(
            validatorSimplifiedModel: validatorSimplifiedModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'StakingTxUndelegateRoute';

  static const _i17.PageInfo<StakingTxUndelegateRouteArgs> page =
      _i17.PageInfo<StakingTxUndelegateRouteArgs>(name);
}

class StakingTxUndelegateRouteArgs {
  const StakingTxUndelegateRouteArgs({
    required this.validatorSimplifiedModel,
    this.key,
  });

  final _i25.ValidatorSimplifiedModel validatorSimplifiedModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'StakingTxUndelegateRouteArgs{validatorSimplifiedModel: $validatorSimplifiedModel, key: $key}';
  }
}

/// generated route for
/// [_i14.TransactionsWrapper]
class TransactionsWrapperRoute extends _i17.PageRouteInfo<void> {
  const TransactionsWrapperRoute({List<_i17.PageRouteInfo>? children})
      : super(
          TransactionsWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionsWrapperRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.TxSendTokensPage]
class TxSendTokensRoute extends _i17.PageRouteInfo<TxSendTokensRouteArgs> {
  TxSendTokensRoute({
    _i26.BalanceModel? defaultBalanceModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          TxSendTokensRoute.name,
          args: TxSendTokensRouteArgs(
            defaultBalanceModel: defaultBalanceModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'TxSendTokensRoute';

  static const _i17.PageInfo<TxSendTokensRouteArgs> page =
      _i17.PageInfo<TxSendTokensRouteArgs>(name);
}

class TxSendTokensRouteArgs {
  const TxSendTokensRouteArgs({
    this.defaultBalanceModel,
    this.key,
  });

  final _i26.BalanceModel? defaultBalanceModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'TxSendTokensRouteArgs{defaultBalanceModel: $defaultBalanceModel, key: $key}';
  }
}

/// generated route for
/// [_i16.ValidatorsPage]
class ValidatorsRoute extends _i17.PageRouteInfo<void> {
  const ValidatorsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ValidatorsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ValidatorsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
