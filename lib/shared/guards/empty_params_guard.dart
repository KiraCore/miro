import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class EmptyParamsGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.toPageRouteInfo().args == null) {
      resolver.next(false);
      router.replace(const PagesRoute(children: <PageRouteInfo>[
        DashboardRoute(),
      ]));
    } else {
      resolver.next(true);
    }
  }
}
