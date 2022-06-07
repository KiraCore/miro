import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/network/network_bloc.dart';
import 'package:miro/config/locator.dart';

class UrlParametersGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    NetworkBloc networkBloc = globalLocator<NetworkBloc>();
    String? currentRpcUrl = resolver.route.queryParams.getString('rpc', '');
    currentRpcUrl = currentRpcUrl.isEmpty ? null : currentRpcUrl;
    String? expectedRpcUrl = networkBloc.connectedNetworkUri?.toString();

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
