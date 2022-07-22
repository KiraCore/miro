import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/network/i_network_list_loader.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class NetworkListCubit extends Cubit<ANetworkListState> {
  final NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();

  List<ANetworkStatusModel> _networkStatusModelsList = List<ANetworkStatusModel>.empty(growable: true);

  NetworkListCubit() : super(NetworkListLoadingState());

  NetworkListCubit.init() : super(NetworkListLoadingState()) {
    initNetworkList();
  }

  Future<void> initNetworkList() async {
    List<NetworkUnknownModel> cfgNetUnknownModelsList = await _loadNetworkStatusModelsFromConfig();
    _networkStatusModelsList = List<ANetworkStatusModel>.from(cfgNetUnknownModelsList);
    emit(NetworkListLoadedState(networkStatusModelsList: _networkStatusModelsList));
    _updateNetworksInfo();
  }

  Future<List<NetworkUnknownModel>> _loadNetworkStatusModelsFromConfig() async {
    INetworkListLoader networkListLoader = globalLocator<INetworkListLoader>();
    return networkListLoader.loadNetworkListConfig();
  }

  void _updateNetworksInfo() {
    for (int i = 0; i < _networkStatusModelsList.length; i++) {
      _updateNetworkStatusModel(i);
    }
  }

  Future<void> _updateNetworkStatusModel(int index) async {
    ANetworkStatusModel newNetworkStatusModel = await _getNetworkStatusModelFromInterx(index);
    _networkStatusModelsList[index] = newNetworkStatusModel;
    emit(NetworkListLoadedState(networkStatusModelsList: _networkStatusModelsList));
  }

  Future<ANetworkStatusModel> _getNetworkStatusModelFromInterx(int index) async {
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel.fromNetworkStatusModel(
      _networkStatusModelsList[index],
    );
    ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(networkUnknownModel);
    return networkStatusModel;
  }
}
