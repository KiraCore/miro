import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/browser_utils.dart';

class NetworkBrowserUrlUtils {
  static String networkQueryParameterKey = 'rpc';

  static String? getNetworkAddress({Uri? optionalNetworkUri}) {
    Uri baseUri = optionalNetworkUri ?? Uri.base;
    String? interxAddress = baseUri.queryParameters['rpc'];
    return (interxAddress ?? '').isNotEmpty ? interxAddress : null;
  }

  static void addNetworkAddress(ANetworkStatusModel networkStatusModel) {
    Uri uri = Uri.base;
    Map<String, dynamic> queryParameters = getQueryParametersForNetwork(uri.queryParameters, networkStatusModel);
    _setQueryParameters(uri, queryParameters);
  }

  static Map<String, dynamic> getQueryParametersForNetwork(
    Map<String, dynamic> currentQueryParameters,
    ANetworkStatusModel? networkStatusModel,
  ) {
    Map<String, dynamic> queryParameters = <String, dynamic>{
      ...currentQueryParameters,
      if (networkStatusModel != null) networkQueryParameterKey: networkStatusModel.uri.toString(),
    };
    return queryParameters;
  }

  static void removeNetworkAddress() {
    Uri uri = Uri.base;
    Map<String, dynamic> queryParameters = Map<String, dynamic>.from(uri.queryParameters)
      ..remove(networkQueryParameterKey);
    _setQueryParameters(uri, queryParameters);
  }

  static void _setQueryParameters(Uri previousUri, Map<String, dynamic> queryParameters) {
    Uri newUri = previousUri.replace(queryParameters: queryParameters);
    BrowserUtils.replaceUrl(newUri);
  }
}
