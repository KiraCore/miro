import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appListProviders = <SingleChildWidget>[
  ChangeNotifierProvider<NetworkProvider>.value(
    value: globalLocator<NetworkProvider>(),
  ),
  ChangeNotifierProvider<WalletProvider>.value(
    value: globalLocator<WalletProvider>(),
  ),
  ChangeNotifierProvider<TokensProvider>.value(
    value: globalLocator<TokensProvider>(),
  ),
  BlocProvider<DrawerCubit>(
    lazy: false,
    create: (BuildContext context) => DrawerCubit(),
  ),
  BlocProvider<NetworkConnectorCubit>(
    lazy: false,
    create: (BuildContext context) => NetworkConnectorCubit(
      queryInterxStatusService: globalLocator<QueryInterxStatusService>(),
      queryValidatorsService: globalLocator<QueryValidatorsService>(),
      networkProvider: globalLocator<NetworkProvider>(),
    ),
  ),
  BlocProvider<NetworkListCubit>(
    lazy: false,
    create: (BuildContext context) => NetworkListCubit(
      queryInterxStatusService: globalLocator<QueryInterxStatusService>(),
      networkConnectorCubit: BlocProvider.of<NetworkConnectorCubit>(context),
    ),
  ),
  ...listCubits,
];

List<SingleChildWidget> listCubits = <SingleChildWidget>[
  BlocProvider<BalanceListBloc>(
    lazy: false,
    create: (BuildContext context) => BalanceListBloc.init(
      queryBalanceService: globalLocator<QueryBalanceService>(),
      walletProvider: globalLocator<WalletProvider>(),
      networkProvider: globalLocator<NetworkProvider>(),
    ),
  ),
];
