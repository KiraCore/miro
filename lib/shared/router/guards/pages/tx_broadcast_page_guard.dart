import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class TxBroadcastPageGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    PageRouteInfo pageRouteInfo = resolver.route.toPageRouteInfo();
    if (pageRouteInfo.args is TxBroadcastRouteArgs) {
      TxBroadcastRouteArgs txBroadcastRouteArgs = pageRouteInfo.args as TxBroadcastRouteArgs;
      if (txBroadcastRouteArgs.signedTxModel == null) {
        resolver.next(false);
        return;
      }
      resolver.next();
    }
  }
}
