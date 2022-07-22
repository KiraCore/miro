import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkListLoadedState extends ANetworkListState {
  final List<ANetworkStatusModel> networkStatusModelsList;

  NetworkListLoadedState({
    required List<ANetworkStatusModel> networkStatusModelsList,
  }) : networkStatusModelsList = List<ANetworkStatusModel>.from(networkStatusModelsList);

  @override
  List<Object> get props => <Object>[networkStatusModelsList];
}
