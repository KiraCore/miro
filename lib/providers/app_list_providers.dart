import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/layout/drawer/drawer_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appListProviders = <SingleChildWidget>[
  ChangeNotifierProvider<AppConfigProvider>.value(
    value: globalLocator<AppConfigProvider>(),
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
