import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/browser_utils.dart';

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
    bool otherNetwork = newNetwork?.parsedUri.toString() != _currentNetworkModel?.parsedUri.toString();
    _currentNetworkModel = newNetwork;
    _updateUrlParams(newNetwork);
    if (otherNetwork && isConnected && _currentNetworkModel!.isConnected) {
      _onNetworkChanged();
    }
    notifyListeners();
  }

  void _updateUrlParams(NetworkModel? newNetwork) {
    Uri currentUrl = Uri.base;
    currentUrl = currentUrl.replace(queryParameters: <String, dynamic>{
      'rpc': newNetwork != null ? newNetwork.parsedUri.toString() : '',
    });
    BrowserUtils.replaceUrl(currentUrl);
  }

  void _onNetworkChanged() {
    globalLocator<TokensProvider>().refreshData();
  }
}
