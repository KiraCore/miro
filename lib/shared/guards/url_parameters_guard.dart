import 'package:auto_route/auto_route.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class UrlParametersGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
    ANetworkStatusModel? networkStatusModel = networkModuleBloc.state.networkStatusModel;
    RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();

    Map<String, dynamic> currentQueryParameters = resolver.route.queryParams.rawMap;
    String connectedNetworkAddress = networkStatusModel.uri.toString();
    String? urlNetworkAddress = currentQueryParameters[RpcBrowserUrlController.rpcQueryParameterKey] as String?;

    if (urlNetworkAddress != connectedNetworkAddress) {
      resolver.next(false);
      Map<String, dynamic> queryParameters = rpcBrowserUrlController.extractQueryParameters(
        currentQueryParameters: currentQueryParameters,
        networkStatusModel: networkStatusModel,
      );
      router.replace(PageRouteInfo<dynamic>.fromMatch(resolver.route).copyWith(queryParams: queryParameters));
    } else {
      resolver.next(true);
    }
  }
}
