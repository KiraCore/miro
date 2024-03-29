import 'package:miro/shared/controllers/browser/browser_url_controller.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class RpcBrowserUrlController {
  static String rpcQueryParameterKey = 'rpc';

  final BrowserUrlController browserUrlController;

  RpcBrowserUrlController({
    this.browserUrlController = const BrowserUrlController(),
  });

  String? getRpcAddress() {
    Map<String, dynamic> queryParameters = browserUrlController.extractQueryParameters();
    String? rpcAddress = queryParameters[rpcQueryParameterKey] as String?;

    if (rpcAddress == null) {
      return null;
    } else if (rpcAddress.isEmpty) {
      return null;
    } else {
      return rpcAddress;
    }
  }

  void setRpcAddress(ANetworkStatusModel networkStatusModel) {
    Map<String, dynamic> queryParameters = extractQueryParameters(
      currentQueryParameters: browserUrlController.extractQueryParameters(),
      networkStatusModel: networkStatusModel,
    );
    browserUrlController.replaceQueryParameters(queryParameters);
  }

  Map<String, dynamic> extractQueryParameters({
    required Map<String, dynamic> currentQueryParameters,
    ANetworkStatusModel? networkStatusModel,
  }) {
    Map<String, dynamic> queryParameters = Map<String, dynamic>.from(currentQueryParameters);
    if (networkStatusModel == null) {
      queryParameters.remove(rpcQueryParameterKey);
      return queryParameters;
    } else {
      queryParameters = <String, dynamic>{
        ...queryParameters,
        rpcQueryParameterKey: networkStatusModel.uri.toString(),
      };
      return queryParameters;
    }
  }

  void removeRpcAddress() {
    Map<String, dynamic> queryParameters = browserUrlController.extractQueryParameters()..remove(rpcQueryParameterKey);
    browserUrlController.replaceQueryParameters(queryParameters);
  }
}
