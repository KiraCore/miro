import 'package:miro/blocs/specific_blocs/network_module/a_network_module_event.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkModuleConnectEvent extends ANetworkModuleEvent {
  final NetworkUnknownModel networkUnknownModel;
  final bool avoidMultipleRequests;

  const NetworkModuleConnectEvent(
    this.networkUnknownModel, {
    this.avoidMultipleRequests = true,
  });
}
