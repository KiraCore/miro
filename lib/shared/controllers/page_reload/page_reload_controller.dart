import 'package:miro/shared/controllers/page_reload/page_reload_condition_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class PageReloadController {
  /// Stores condition when the shouldReload() method should return true
  final PageReloadConditionType pageReloadConditionType;

  /// Holds a unique number identifying current refresh
  /// If local refresh id is different from [activeReloadId] old reload operation should be canceled
  int _activeReloadId = 0;

  /// Stores information about whether last query was successful
  bool _hasErrors = false;

  /// Stores network that was used to perform last query
  ANetworkStatusModel? _usedNetworkStatusModel;

  PageReloadController({
    required this.pageReloadConditionType,
  });

  int get activeReloadId => _activeReloadId;

  set hasErrors(bool value) => _hasErrors = value;

  bool canReloadStart(ANetworkStatusModel networkStatusModel) {
    bool isDifferentNetwork = _usedNetworkStatusModel?.uri != networkStatusModel.uri;

    if (_hasErrors) {
      // If previous reload has errors, should always refresh
      return true;
    } else if (pageReloadConditionType == PageReloadConditionType.changedNetwork) {
      return isDifferentNetwork;
    } else {
      return false;
    }
  }

  bool canReloadComplete(int reloadId) {
    return reloadId == _activeReloadId;
  }

  void handleReloadCall(ANetworkStatusModel usedNetworkStatusModel) {
    _usedNetworkStatusModel = usedNetworkStatusModel;
    _hasErrors = false;
    _activeReloadId += 1;
  }
}
