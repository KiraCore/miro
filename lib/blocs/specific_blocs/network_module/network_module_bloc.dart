import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/a_network_module_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connecting_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_refresh_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';

class NetworkModuleBloc extends Bloc<ANetworkModuleEvent, NetworkModuleState> {
  final NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();
  final NetworkListCubit networkListCubit = globalLocator<NetworkListCubit>();
  final AppConfig appConfig = globalLocator<AppConfig>();
  final RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();
  late Timer timer;
  bool isRefreshing = false;

  NetworkModuleBloc() : super(NetworkModuleState.disconnected()) {
    on<NetworkModuleInitEvent>(_mapInitEventToState);
    on<NetworkModuleRefreshEvent>(_mapRefreshEventToState);
    on<NetworkModuleSetUpEvent>(_mapSetUpEventToState);
    on<NetworkModuleConnectEvent>(_mapConnectEventToState);
    on<NetworkModuleConnectingEvent>(_mapConnectingEventToState);
    on<NetworkModuleDisconnectEvent>(_mapDisconnectEventToState);
  }

  Future<void> _mapInitEventToState(NetworkModuleInitEvent networkModuleInitEvent, Emitter<NetworkModuleState> emit) async {
    NetworkUnknownModel defaultNetworkUnknownModel = await appConfig.getDefaultNetworkUnknownModel();

    add(NetworkModuleSetUpEvent(defaultNetworkUnknownModel));
    _updateNetworkStatusModelList(ignoreNetworkUnknownModel: defaultNetworkUnknownModel);

    timer = Timer.periodic(appConfig.refreshInterval, (Timer timer) {
      // TODO(dominik): Debug info. Should be removed before release
      print('Refreshing Network: ${timer.tick}');
      add(NetworkModuleRefreshEvent());
    });
  }

  Future<void> _mapRefreshEventToState(NetworkModuleRefreshEvent networkModuleRefreshEvent, Emitter<NetworkModuleState> emit) async {
    if (isRefreshing) {
      return;
    }
    isRefreshing = true;
    if (state.isConnected) {
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel.fromNetworkStatusModel(state.networkStatusModel);
      ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(networkUnknownModel);

      networkListCubit.setNetworkStatusModel(networkStatusModel: networkStatusModel);

      if (networkStatusModel.uri != state.networkStatusModel.uri) {
        return;
      }

      if (networkStatusModel is ANetworkOnlineModel) {
        emit(NetworkModuleState.connected(networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.connected)));
      } else {
        add(NetworkModuleDisconnectEvent());
      }
      _updateNetworkStatusModelList(ignoreNetworkUnknownModel: networkUnknownModel);
    } else {
      _updateNetworkStatusModelList();
    }
    isRefreshing = false;
  }

  Future<void> _mapSetUpEventToState(NetworkModuleSetUpEvent networkModuleSetUpEvent, Emitter<NetworkModuleState> emit) async {
    NetworkUnknownModel networkUnknownModel =
        networkModuleSetUpEvent.networkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting);
    emit(NetworkModuleState.connecting(networkUnknownModel));

    ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(networkUnknownModel);
    networkListCubit.setNetworkStatusModel(
      networkStatusModel: networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
    );

    if (networkStatusModel.uri != state.networkStatusModel.uri) {
      return;
    }

    if (networkStatusModel is NetworkHealthyModel) {
      add(NetworkModuleConnectingEvent(networkStatusModel));
    } else {
      add(NetworkModuleDisconnectEvent());
    }
  }

  Future<void> _mapConnectEventToState(NetworkModuleConnectEvent networkModuleConnectEvent, Emitter<NetworkModuleState> emit) async {
    ANetworkOnlineModel networkOnlineModel =
        networkModuleConnectEvent.networkOnlineModel.copyWith(connectionStatusType: ConnectionStatusType.connecting);
    emit(NetworkModuleState.connecting(networkOnlineModel));
    add(NetworkModuleConnectingEvent(networkOnlineModel));
  }

  Future<void> _mapConnectingEventToState(NetworkModuleConnectingEvent networkModuleConnectingEvent, Emitter<NetworkModuleState> emit) async {
    if (!state.isConnecting) {
      return;
    }
    ANetworkOnlineModel networkOnlineModel = networkModuleConnectingEvent.networkOnlineModel;
    networkOnlineModel = networkOnlineModel.copyWith(connectionStatusType: ConnectionStatusType.connected);
    rpcBrowserUrlController.setRpcAddress(networkOnlineModel);
    emit(NetworkModuleState.connected(networkOnlineModel));
  }

  Future<void> _mapDisconnectEventToState(
    NetworkModuleDisconnectEvent networkModuleDisconnectEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    rpcBrowserUrlController.removeRpcAddress();
    emit(NetworkModuleState.disconnected());
  }

  void _updateNetworkStatusModelList({NetworkUnknownModel? ignoreNetworkUnknownModel}) {
    List<ANetworkStatusModel> networkStatusModelList = networkListCubit.networkStatusModelList;
    for (ANetworkStatusModel networkStatusModel in networkStatusModelList) {
      if (networkStatusModel.uri != ignoreNetworkUnknownModel?.uri) {
        _updateNetworkStatusModel(
          networkUnknownModel: NetworkUnknownModel.fromNetworkStatusModel(
            networkStatusModel.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
          ),
        );
      }
    }
  }

  Future<void> _updateNetworkStatusModel({required NetworkUnknownModel networkUnknownModel}) async {
    ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(networkUnknownModel);
    networkListCubit.setNetworkStatusModel(networkStatusModel: networkStatusModel);
  }
}
