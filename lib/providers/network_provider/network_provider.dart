import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/shared/models/network_model.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkState state = DisconnectedNetworkState();

  bool get isConnected => state is ConnectedNetworkState;

  Uri? get networkUri {
    if (state is ConnectedNetworkState) {
      return (state as ConnectedNetworkState).networkModel.parsedUri;
    }
    return null;
  }

  NetworkModel? get networkModel {
    if (state is ConnectedNetworkState) {
      return (state as ConnectedNetworkState).networkModel;
    }
    return null;
  }

  void handleEvent(NetworkEvent networkEvent) {
    networkEvent.invoke(this);
  }

  void setState(NetworkState networkState) {
    state = networkState;
    notifyListeners();
  }

  void onNetworkChanged() {
    globalLocator<TokensProvider>().refreshData();
  }
}
