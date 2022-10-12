import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (globalLocator<WalletProvider>().isLoggedIn) {
      resolver.next(true);
    } else {
      resolver.next(false);
      router.root.replaceAll(<PageRouteInfo>[
        const PagesWrapperRoute(children: <PageRouteInfo>[DashboardRoute()])
      ]);
    }
  }
}
