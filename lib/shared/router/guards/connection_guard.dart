import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';

class ConnectionGuard extends AutoRouteGuard {
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (networkModuleBloc.state.isConnected) {
      resolver.next(true);
    } else {
      resolver.next(false);
      KiraRouter(router).root.replaceAll(<PageRouteInfo>[const LoadingWrapperRoute()]);
    }
  }
}
