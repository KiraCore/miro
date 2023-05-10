import 'package:miro/blocs/generic/network_module/a_network_module_event.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkModuleConnectEvent extends ANetworkModuleEvent {
  final ANetworkOnlineModel networkOnlineModel;

  const NetworkModuleConnectEvent(this.networkOnlineModel);

  @override
  List<Object?> get props => <Object?>[networkOnlineModel];
}
