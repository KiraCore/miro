import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/browser_utils.dart';

// ignore: one_member_abstracts
abstract class NetworkEvent {
  void invoke(NetworkProvider networkProvider);
}

class ConnectToNetworkEvent extends NetworkEvent {
  final NetworkModel networkModel;

  ConnectToNetworkEvent(this.networkModel);

  @override
  void invoke(NetworkProvider networkProvider) {
    networkProvider.setState(ConnectingNetworkState(networkModel));
  }
}

class SetUpNetworkEvent extends NetworkEvent {
  final NetworkModel networkModel;

  SetUpNetworkEvent(this.networkModel);

  @override
  void invoke(NetworkProvider networkProvider) {
    NetworkState networkState = networkProvider.state;
    if (networkState is! ConnectingNetworkState) {
      return;
    }
    NetworkModel? previousNetworkModel;
    if (networkState is ConnectedNetworkState) {
      previousNetworkModel = networkState.networkModel;
    }

    bool otherNetwork = previousNetworkModel?.parsedUri.toString() != networkModel.parsedUri.toString();
    updateUrlParams(networkModel);
    networkProvider.setState(ConnectedNetworkState(networkModel));
    if (otherNetwork && networkModel.isConnected) {
      networkProvider.onNetworkChanged();
    }
  }

  void updateUrlParams(NetworkModel? newNetwork) {
    Uri currentUrl = Uri.base;
    currentUrl = currentUrl.replace(queryParameters: <String, dynamic>{
      'rpc': newNetwork != null ? newNetwork.parsedUri.toString() : '',
    });
    BrowserUtils.replaceUrl(currentUrl);
  }
}

class DisconnectNetworkEvent extends NetworkEvent {
  @override
  void invoke(NetworkProvider networkProvider) {
    networkProvider.setState(DisconnectedNetworkState());
  }
}
