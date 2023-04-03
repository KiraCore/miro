import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/utils/router_utils.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit _authCubit = globalLocator<AuthCubit>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authCubit.isSignedIn) {
      resolver.next(true);
    } else {
      resolver.next(false);
      PageRouteInfo defaultPageRouteInfo = _buildDefaultRoute(router);
      KiraRouter(router).navigate(defaultPageRouteInfo);
    }
  }

  PageRouteInfo _buildDefaultRoute(StackRouter router) {
    List<String> currentRouteHistory = RouterUtils.getParentRouterNames(router);
    List<PageRouteInfo> defaultPageRouteInfoStack = RouterUtils.defaultRoute.flattened.reversed.toList();
    late PageRouteInfo defaultRoute;

    for (int i = 0; i < defaultPageRouteInfoStack.length; i++) {
      PageRouteInfo pageRouteInfo = defaultPageRouteInfoStack[i];
      if (i == 0) {
        defaultRoute = pageRouteInfo;
        continue;
      }
      bool isRouteInStack = currentRouteHistory.contains(pageRouteInfo.routeName);
      if (isRouteInStack == false) {
        defaultRoute = pageRouteInfo.copyWith(children: <PageRouteInfo>[defaultRoute]);
      }
    }
    return defaultRoute;
  }
}
