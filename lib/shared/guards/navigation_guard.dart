import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/menu_provider.dart';

class NavigationGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    globalLocator<MenuProvider>().updatePath(resolver.route.path);
    resolver.next(true);
  }
}
