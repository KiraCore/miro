import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkListLoadedState extends ANetworkListState {
  final List<ANetworkStatusModel> networkStatusModels;

  NetworkListLoadedState({
    required List<ANetworkStatusModel> networkStatusModels,
  }) : networkStatusModels = List<ANetworkStatusModel>.from(networkStatusModels);

  @override
  List<Object> get props => <Object>[networkStatusModels];
}
