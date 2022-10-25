import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class RouterUtils {
  static const PageRouteInfo<dynamic> defaultRoute = PagesWrapperRoute(children: <PageRouteInfo>[
    MenuWrapperRoute(children: <PageRouteInfo>[
      DashboardRoute(),
    ])
  ]);

  static PageRouteInfo<dynamic> getNextRouteAfterLoading(RouteMatch<dynamic>? initialRouteMatch) {
    if (initialRouteMatch == null) {
      return defaultRoute;
    }
    List<RouteMatch<dynamic>> initialRouteMatchChildren = initialRouteMatch.children ?? List<RouteMatch<dynamic>>.empty();
    List<String> childrenNames = initialRouteMatchChildren.map((RouteMatch<dynamic> route) => route.name).toList();
    if (childrenNames.contains(LoadingWrapperRoute.name)) {
      return defaultRoute;
    }

    return PageRouteInfo<dynamic>.fromMatch(initialRouteMatch);
  }

  static List<String> getParentRouterNames(StackRouter router) {
    List<String> currentRouteHistory = List<String>.empty(growable: true);
    StackRouter? currentRouter = router;
    while (currentRouter != null) {
      currentRouteHistory.add(currentRouter.routeData.name);
      currentRouter = currentRouter.parentAsStackRouter;
    }
    return currentRouteHistory;
  }
}
