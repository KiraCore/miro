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
    initNetworks();
  }

  Future<void> initNetworks() async {
    List<ANetworkStatusModel> configNetworkStatusModels = await _loadNetworkStatusModelsFromConfig();
    _networkList = configNetworkStatusModels;
    emit(NetworkListLoadedState(networkStatusModels: List<ANetworkStatusModel>.from(_networkList)));

    for (int i = 0; i < configNetworkStatusModels.length; i++) {
      _updateNetworkStatus(i);
    }
  }

  void _updateNetworkStatus(int index) {
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel.fromNetworkStatusModel(_networkList[index]);
    networkUtilsService.getNetworkStatusModel(networkUnknownModel).then(
        (ANetworkStatusModel newNetworkStatusModel) async {
      _networkList[index] = newNetworkStatusModel;
      emit(NetworkListLoadedState(networkStatusModels: List<ANetworkStatusModel>.from(_networkList)));
    }, onError: (Object error) {
      AppLogger().log(message: 'Cannot set network status for $networkUnknownModel');
      _networkList[index] = NetworkOfflineModel.fromRequest(networkUnknownModel);
      emit(NetworkListLoadedState(networkStatusModels: List<ANetworkStatusModel>.from(_networkList)));
    });
  }

  Future<List<ANetworkStatusModel>> _loadNetworkStatusModelsFromConfig() async {
    INetworkListLoader networkListLoader = globalLocator<INetworkListLoader>();
    return networkListLoader.loadNetworkListConfig();
  }
}
