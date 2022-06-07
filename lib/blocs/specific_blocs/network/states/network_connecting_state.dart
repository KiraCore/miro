import 'package:miro/blocs/specific_blocs/network/states/a_network_connectable_state.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkConnectingState extends ANetworkConnectableState {
  const NetworkConnectingState({
    required NetworkUnknownModel networkUnknownModel,
  }) : super(networkStatusModel: networkUnknownModel);
}
