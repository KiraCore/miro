import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class RouterUtils {
  static const PageRouteInfo<dynamic> _defaultRoute = PagesWrapperRoute(children: <PageRouteInfo>[
    MenuRoute(children: <PageRouteInfo>[
      DashboardRoute(),
    ])
  ]);

  static PageRouteInfo<dynamic> getNextRouteAfterLoading(RouteMatch<dynamic>? initialRouteMatch) {
    if (initialRouteMatch == null) {
      return _defaultRoute;
    }
    List<RouteMatch<dynamic>> initialRouteMatchChildren = initialRouteMatch.children ?? List<RouteMatch<dynamic>>.empty();
    List<String> childrenNames = initialRouteMatchChildren.map((RouteMatch<dynamic> route) => route.name).toList();
    if (childrenNames.contains(LoadingWrapperRoute.name)) {
      return _defaultRoute;
    }

    return PageRouteInfo<dynamic>.fromMatch(initialRouteMatch);
  }
}
