import 'package:auto_route/auto_route.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

class UrlParametersGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    String? currentRpcUrl = resolver.route.queryParams.getString('rpc', '');
    currentRpcUrl = currentRpcUrl.isEmpty ? null : currentRpcUrl;
    String? expectedRpcUrl = networkProvider.networkUri?.toString();

    if (expectedRpcUrl != null && currentRpcUrl != expectedRpcUrl) {
      resolver.next(false);
      router.navigate(PageRouteInfo<dynamic>.fromMatch(resolver.route).copyWith(
        queryParams: <String, dynamic>{
          'rpc': expectedRpcUrl,
        },
      ));
    } else {
      resolver.next(true);
    }
  }
}
