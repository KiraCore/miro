import 'package:miro/blocs/specific_blocs/network/a_network_event.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkConnectEvent extends ANetworkEvent {
  final NetworkUnknownModel networkUnknownModel;
  final bool avoidMultipleRequests;

  const NetworkConnectEvent(
    this.networkUnknownModel, {
    this.avoidMultipleRequests = true,
  });
}
