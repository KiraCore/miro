import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_list/a_network_list_state.dart';
import 'package:miro/blocs/widgets/network_list/network_list/states/network_list_loaded_state.dart';
import 'package:miro/blocs/widgets/network_list/network_list/states/network_list_loading_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkListCubit extends Cubit<ANetworkListState> {
  final AppConfig appConfig = globalLocator<AppConfig>();

  List<ANetworkStatusModel> networkStatusModelList = List<ANetworkStatusModel>.empty(growable: true);

  NetworkListCubit() : super(NetworkListLoadingState());

  void initNetworkStatusModelList() {
    networkStatusModelList = List<ANetworkStatusModel>.from(appConfig.networkList);
    emit(NetworkListLoadedState(networkStatusModelList: networkStatusModelList));
  }

  void setNetworkStatusModel({required ANetworkStatusModel networkStatusModel}) {
    int networkStatusModelIndex = networkStatusModelList.indexWhere((ANetworkStatusModel e) => e.uri.host == networkStatusModel.uri.host);
    if (networkStatusModelIndex != -1) {
      networkStatusModelList[networkStatusModelIndex] = networkStatusModel;
      emit(NetworkListLoadedState(networkStatusModelList: networkStatusModelList));
    }
  }
}
