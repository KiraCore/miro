import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class RouterUtils {
  static PageRouteInfo<dynamic> defaultRoute = const MenuWrapperRoute(children: <PageRouteInfo>[DashboardRoute()]);

  static PageRouteInfo<dynamic> getNextRouteAfterLoading(PageRouteInfo? initialPageRouteInfo) {
    if (initialPageRouteInfo == null) {
      return defaultRoute;
    }
    List<PageRouteInfo> initialRouteMatchChildren = initialPageRouteInfo.flattened;
    List<String> childrenNames = initialRouteMatchChildren.map((PageRouteInfo pageRouteInfo) => pageRouteInfo.routeName).toList();
    if (childrenNames.contains(LoadingWrapperRoute.name)) {
      return defaultRoute;
    }
    return initialPageRouteInfo;
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
