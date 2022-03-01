import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/network_utils.dart';

class ConnectionGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (globalLocator<NetworkProvider>().isConnected) {
      resolver.next(true);
    } else if (_hasDefaultNetwork()) {
      router.replace(LoadingWrapperRoute(children: <PageRouteInfo>[
        LoadingRoute(
            nextRoute: resolver.route.copyWith(
          queryParams: Parameters(Uri.base.queryParameters),
        )),
      ]));
      resolver.next(false);
    } else {
      resolver.next(false);

      router.replace(LoadingWrapperRoute(children: <PageRouteInfo>[
        ConnectionsRoute(
            nextRoute: resolver.route.copyWith(
          queryParams: Parameters(Uri.base.queryParameters),
        )),
      ]));
    }
  }

  bool _hasDefaultNetwork() {
    Uri uri = Uri.base;
    String? rpcNetwork = uri.queryParameters['rpc'];
    if (rpcNetwork == null) {
      return false;
    }
    try {
      NetworkUtils.parseUrl(rpcNetwork);
      return true;
    } catch (_) {
      AppLogger().log(message: 'Invalid RPC url');
    }
    return false;
  }
}
