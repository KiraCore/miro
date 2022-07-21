import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/network/network_bloc.dart';
import 'package:miro/blocs/specific_blocs/network/utils/network_browser_url_utils.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class UrlParametersGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    NetworkBloc networkBloc = globalLocator<NetworkBloc>();
    ANetworkStatusModel? networkStatusModel = networkBloc.state.networkStatusModel;

    Map<String, dynamic> currentQueryParameters = resolver.route.queryParams.rawMap;
    String? connectedNetworkAddress = networkStatusModel?.uri.toString();
    String? urlNetworkAddress = currentQueryParameters[NetworkBrowserUrlUtils.networkQueryParameterKey] as String?;

    if (connectedNetworkAddress != null && urlNetworkAddress != connectedNetworkAddress) {
      resolver.next(false);
      Map<String, dynamic> queryParameters = NetworkBrowserUrlUtils.getQueryParametersForNetwork(
        currentQueryParameters,
        networkStatusModel,
      );
      router.navigate(PageRouteInfo<dynamic>.fromMatch(resolver.route).copyWith(queryParams: queryParameters));
    } else {
      resolver.next(true);
    }
  }
}
