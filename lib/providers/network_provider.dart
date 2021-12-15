import 'dart:html';

import 'package:flutter/material.dart';
import 'package:miro/shared/models/network_model.dart';

class NetworkProvider extends ChangeNotifier {
  NetworkModel? _currentNetworkModel;

  NetworkModel? get networkModel => _currentNetworkModel;

  bool get isConnected => _currentNetworkModel != null;

  String? get networkUrl {
    if (isConnected) {
      return _currentNetworkModel!.url;
    }
    return null;
  }

  void changeCurrentNetwork(NetworkModel? newNetwork) {
    _currentNetworkModel = newNetwork;
    _updateUrlParams(newNetwork);
    notifyListeners();
  }

  void _updateUrlParams(NetworkModel? newNetwork) {
    Uri currentUrl = Uri.base;
    currentUrl = currentUrl.replace(queryParameters: <String, dynamic>{
      'rpc': newNetwork != null ? newNetwork.parsedUri.toString() : '',
    });
    window.history.replaceState(<String, dynamic>{}, '', currentUrl.toString());
  }
}
