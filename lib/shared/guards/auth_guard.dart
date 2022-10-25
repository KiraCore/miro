import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/router_utils.dart';

class AuthGuard extends AutoRouteGuard {
  final WalletProvider _walletProvider = globalLocator<WalletProvider>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_walletProvider.isLoggedIn) {
      resolver.next(true);
    } else {
      resolver.next(false);
      PageRouteInfo defaultPageRouteInfo = const DashboardRoute();
      List<String> currentRouteHistory = RouterUtils.getParentRouterNames(router);

      if (currentRouteHistory.contains(MenuWrapperRoute.name) == false) {
        defaultPageRouteInfo = MenuWrapperRoute(
          children: <PageRouteInfo>[defaultPageRouteInfo],
        );
      }

      router.navigate(defaultPageRouteInfo);
    }
  }
}
