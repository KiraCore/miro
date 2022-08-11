import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appListProviders = <SingleChildWidget>[
  ChangeNotifierProvider<AppConfigProvider>.value(
      value: globalLocator<AppConfigProvider>(),
  ),
  ChangeNotifierProvider<WalletProvider>.value(
    value: globalLocator<WalletProvider>(),
  ),
  ChangeNotifierProvider<TokensProvider>.value(
    value: globalLocator<TokensProvider>(),
  ),
  BlocProvider<NetworkModuleBloc>(
    lazy: false,
    create: (BuildContext context) => globalLocator<NetworkModuleBloc>(),
  ),
  BlocProvider<DrawerCubit>(
    lazy: false,
    create: (BuildContext context) => DrawerCubit(),
  ),
  BlocProvider<NetworkListCubit>(
    lazy: false,
    create: (BuildContext context) => globalLocator<NetworkListCubit>(),
  ),
];
