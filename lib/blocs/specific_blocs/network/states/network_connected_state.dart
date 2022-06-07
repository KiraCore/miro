import 'package:miro/blocs/specific_blocs/network/states/a_network_connectable_state.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkConnectedState extends ANetworkConnectableState {
  const NetworkConnectedState({
    required ANetworkOnlineModel networkOnlineModel,
  }) : super(networkStatusModel: networkOnlineModel);
}
