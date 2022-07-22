import 'package:miro/blocs/specific_blocs/network_module/a_network_module_event.dart';

class NetworkModuleConnectFromUrlEvent extends ANetworkModuleEvent {
  final Uri? optionalNetworkUri;

  const NetworkModuleConnectFromUrlEvent({this.optionalNetworkUri});
}
