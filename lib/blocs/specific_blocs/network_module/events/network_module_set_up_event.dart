import 'package:miro/blocs/specific_blocs/network_module/a_network_module_event.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkModuleSetUpEvent extends ANetworkModuleEvent {
  final NetworkUnknownModel networkUnknownModel;

  const NetworkModuleSetUpEvent(
    this.networkUnknownModel,
  );

  @override
  List<Object?> get props => <Object?>[networkUnknownModel];
}
