import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/guards/connection_guard.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/router_utils.dart';

class LoadingPageGuard extends AutoRouteGuard {
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final ConnectionGuard connectionGuard;

  LoadingPageGuard({
    required this.connectionGuard,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (networkModuleBloc.state.isConnecting) {
      resolver.next(true);
    } else if (connectionGuard.initialRouteResolved) {
      resolver.next(false);
      if (networkModuleBloc.state.isConnected) {
        router.navigate(RouterUtils.defaultRoute);
      } else {
        router.navigate(NetworkListRoute());
      }
    }
  }
}
