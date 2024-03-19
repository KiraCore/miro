import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class GlobalNavController {
  static final List<PageRouteInfo<void>> _protectedRoutes = <PageRouteInfo<void>>[
    const MyAccountRoute(),
  ];
  static const PageRouteInfo<void> _defaultRoute = DashboardRoute();
  late final StackRouter router;

  void setRouter(StackRouter router) {
    this.router = router;
  }

  void leaveProtectedPage() {
    for (PageRouteInfo<void> pageRouteInfo in _protectedRoutes) {
      if (router.isRouteActive(pageRouteInfo.routeName)) {
        router.push(_defaultRoute);
        break;
      }
    }
  }
}
