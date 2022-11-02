import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/router.gr.dart';

class TxConfirmPageGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    PageRouteInfo pageRouteInfo = resolver.route.toPageRouteInfo();
    if (pageRouteInfo.args is TxConfirmRouteArgs) {
      TxConfirmRouteArgs txConfirmRouteArgs = pageRouteInfo.args as TxConfirmRouteArgs;
      if (txConfirmRouteArgs.signedTxModel == null) {
        resolver.next(false);
        return;
      }
      resolver.next();
    }
  }
}
