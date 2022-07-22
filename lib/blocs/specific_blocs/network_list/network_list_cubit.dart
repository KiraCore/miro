import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_list/a_network_list_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/network_list/states/network_list_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/network/i_network_list_loader.dart';
import 'package:miro/infra/services/network_utils_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

class NetworkListCubit extends Cubit<ANetworkListState> {
  final NetworkUtilsService networkUtilsService = globalLocator<NetworkUtilsService>();

  List<ANetworkStatusModel> _networkList = List<ANetworkStatusModel>.empty(growable: true);

  NetworkListCubit() : super(NetworkListLoadingState());

  NetworkListCubit.init() : super(NetworkListLoadingState()) {
    initNetworkList();
  }

  Future<void> initNetworkList() async {
    List<NetworkUnknownModel> configNetworkUnknownModels = await _loadNetworkStatusModelsFromConfig();
    _networkList = List<ANetworkStatusModel>.from(configNetworkUnknownModels);
    emit(NetworkListLoadedState(networkStatusModels: _networkList));
    _updateNetworksRemoteInfo();
  }

  Future<List<NetworkUnknownModel>> _loadNetworkStatusModelsFromConfig() async {
    INetworkListLoader networkListLoader = globalLocator<INetworkListLoader>();
    return networkListLoader.loadNetworkListConfig();
  }

  void _updateNetworksRemoteInfo() {
    for (int i = 0; i < _networkList.length; i++) {
      _updateNetworkStatusModel(i);
    }
  }

  Future<void> _updateNetworkStatusModel(int index) async {
    ANetworkStatusModel newNetworkStatusModel = await _getNetworkStatusModelFromInterx(index);
    _networkList[index] = newNetworkStatusModel;
    emit(NetworkListLoadedState(networkStatusModels: _networkList));
  }

  Future<ANetworkStatusModel> _getNetworkStatusModelFromInterx(int index) async {
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel.fromNetworkStatusModel(_networkList[index]);
    try {
      return await networkUtilsService.getNetworkStatusModel(networkUnknownModel);
    } catch (_) {
      AppLogger().log(message: 'Cannot set network status for $networkUnknownModel');
      return NetworkOfflineModel.fromRequest(networkUnknownModel);
    }
  }
}
