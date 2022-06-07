import 'package:miro/blocs/specific_blocs/network/a_network_event.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkSetUpEvent extends ANetworkEvent {
  final ANetworkOnlineModel networkOnlineModel;
  final bool connectingStateRequired;

  const NetworkSetUpEvent(
    this.networkOnlineModel, {
    this.connectingStateRequired = false,
  });
}
