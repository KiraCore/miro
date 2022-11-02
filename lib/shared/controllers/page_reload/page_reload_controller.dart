import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class PageReloadController {
  /// Stores information about whether last query was successful
  bool hasErrors = false;

  /// Holds a unique number identifying current refresh
  /// If local refresh id is different from [activeReloadId] old reload operation should be canceled
  int _activeReloadId = 0;

  /// Stores network that was used to perform last query
  ANetworkStatusModel? _usedNetworkStatusModel;

  PageReloadController();

  int get activeReloadId => _activeReloadId;

  Uri? get usedUri => _usedNetworkStatusModel?.uri;

  bool hasNetworkChanged(ANetworkStatusModel networkStatusModel) {
    bool isDifferentNetwork = _usedNetworkStatusModel?.uri != networkStatusModel.uri;

    return isDifferentNetwork;
  }

  bool canReloadComplete(int reloadId) {
    return reloadId == _activeReloadId;
  }

  void handleReloadCall(ANetworkStatusModel usedNetworkStatusModel) {
    _usedNetworkStatusModel = usedNetworkStatusModel;
    _activeReloadId += 1;
    hasErrors = false;
  }
}
