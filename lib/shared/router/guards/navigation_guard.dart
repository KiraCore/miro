import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/nav_menu/nav_menu_cubit.dart';
import 'package:miro/config/locator.dart';

class NavigationGuard extends AutoRouteGuard {
  final NavMenuCubit navMenuCubit = globalLocator<NavMenuCubit>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    navMenuCubit.updatePath(resolver.route.path);
    resolver.next(true);
  }
}
