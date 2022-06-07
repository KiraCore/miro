import 'package:miro/blocs/specific_blocs/network/a_network_event.dart';

class NetworkConnectFromUrlEvent extends ANetworkEvent {
  final Uri? optionalNetworkUri;

  const NetworkConnectFromUrlEvent({this.optionalNetworkUri});
}
