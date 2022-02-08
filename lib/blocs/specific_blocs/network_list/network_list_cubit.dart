import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/assets_manager.dart';

part 'network_list_state.dart';

class NetworkListCubit extends Cubit<NetworkListState> {
  final QueryInterxStatusService queryInterxStatusService;
  final NetworkConnectorCubit networkConnectorCubit;

  List<NetworkModel> networkList = List<NetworkModel>.empty(growable: true);

  NetworkListCubit({
    required this.queryInterxStatusService,
    required this.networkConnectorCubit,
  }) : super(NetworkListInitialState()) {
    getNetworks();
  }

  Future<void> getNetworks() async {
    List<NetworkModel> staticNetworks = await _fetchNetworkList();
    networkList = staticNetworks;
    emit(NetworkListLoadingState());
    emit(NetworkListLoadedState(networkList: staticNetworks));

    for (int i = 0; i < staticNetworks.length; i++) {
      _updateNetworkStatus(i);
    }
  }

  void _updateNetworkStatus(int index) {
    networkConnectorCubit.getNetworkData(networkList[index]).then((NetworkModel newNetworkModel) async {
      networkList[index] = newNetworkModel;
      emit(NetworkListLoadingState());
      emit(NetworkListLoadedState(networkList: networkList));
    });
  }

  Future<List<NetworkModel>> _fetchNetworkList() async {
    Map<String, dynamic> json = await AssetsManager().getAsMap('assets/network_list_config.json');
    return (json['network_list'] as List<dynamic>)
        .map((dynamic e) => NetworkModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
