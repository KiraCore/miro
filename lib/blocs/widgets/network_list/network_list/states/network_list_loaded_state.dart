import 'package:miro/blocs/widgets/network_list/network_list/a_network_list_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkListLoadedState extends ANetworkListState {
  final List<ANetworkStatusModel> networkStatusModelList;

  NetworkListLoadedState({
    required List<ANetworkStatusModel> networkStatusModelList,
  }) : networkStatusModelList = List<ANetworkStatusModel>.from(networkStatusModelList);

  @override
  List<Object> get props => <Object>[networkStatusModelList];
}
