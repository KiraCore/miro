import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';

class ConnectionGuard extends AutoRouteGuard {
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();

  bool initialRouteResolved = false;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (initialRouteResolved) {
      resolver.next(true);
      return;
    }
    initialRouteResolved = true;

    if (networkModuleBloc.state.isConnected) {
      resolver.next(true);
    } else if (networkModuleBloc.state.isConnecting) {
      _navigateToLoadingPage(resolver, router);
      resolver.next(false);
    } else {
      _navigateToConnectionsPage(resolver, router);
      resolver.next(false);
    }
  }

  void _navigateToLoadingPage(NavigationResolver resolver, StackRouter router) {
    KiraRouter(router).root.replaceAll(
      <PageRouteInfo>[
        PagesWrapperRoute(
          children: <PageRouteInfo>[
            LoadingWrapperRoute(
              children: <PageRouteInfo>[
                LoadingRoute(nextPageRouteInfo: resolver.route.toPageRouteInfo()),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToConnectionsPage(NavigationResolver resolver, StackRouter router) {
    KiraRouter(router).root.replaceAll(
      <PageRouteInfo>[
        PagesWrapperRoute(
          children: <PageRouteInfo>[
            LoadingWrapperRoute(
              children: <PageRouteInfo>[
                NetworkListRoute(
                  nextPageRouteInfo: resolver.route.toPageRouteInfo(),
                  connectionErrorType: ConnectionErrorType.canceledByUser,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
