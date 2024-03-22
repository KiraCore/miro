import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/network_module/a_network_module_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_auto_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_refresh_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_empty_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkModuleBloc extends Bloc<ANetworkModuleEvent, NetworkModuleState> {
  final Completer<void> initializationCompleter = Completer<void>();

  final AppConfig _appConfig = globalLocator<AppConfig>();
  final NetworkListCubit _networkListCubit = globalLocator<NetworkListCubit>();
  final NetworkCustomSectionCubit _networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();
  final NetworkModuleService _networkModuleService = globalLocator<NetworkModuleService>();
  final RpcBrowserUrlController _rpcBrowserUrlController = RpcBrowserUrlController();

  late Timer _timer;

  NetworkModuleBloc() : super(NetworkModuleState.disconnected()) {
    on<NetworkModuleInitEvent>(_mapInitEventToState);
    on<NetworkModuleRefreshEvent>(_mapRefreshEventToState);
    on<NetworkModuleAutoConnectEvent>(_mapAutoConnectEventToState);
    on<NetworkModuleConnectEvent>(_mapConnectEventToState);
    on<NetworkModuleDisconnectEvent>(_mapDisconnectEventToState);
  }

  @override
  Future<void> close() async {
    _timer.cancel();
    await super.close();
  }

  Future<void> _mapInitEventToState(NetworkModuleInitEvent networkModuleInitEvent, Emitter<NetworkModuleState> emit) async {
    NetworkUnknownModel defaultNetworkUnknownModel = await _appConfig.getDefaultNetworkUnknownModel();

    add(NetworkModuleAutoConnectEvent(defaultNetworkUnknownModel));
    _updateNetworkStatusModelList(ignoreNetworkUnknownModel: defaultNetworkUnknownModel);

    _timer = Timer.periodic(_appConfig.refreshInterval, (Timer timer) {
      // TODO(dominik): Debug info. Should be removed before release
      // ignore: avoid_print
      print('Refreshing Network: ${timer.tick}');
      add(NetworkModuleRefreshEvent());
    });
  }

  Future<void> _mapRefreshEventToState(NetworkModuleRefreshEvent networkModuleRefreshEvent, Emitter<NetworkModuleState> emit) async {
    if (state.networkStatusModel is NetworkEmptyModel || state.isRefreshing) {
      _updateNetworkStatusModelList();
    } else {
      emit(NetworkModuleState.refreshing(state.networkStatusModel));
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel.fromNetworkStatusModel(state.networkStatusModel);
      ANetworkStatusModel networkStatusModel = await _networkModuleService.getNetworkStatusModel(networkUnknownModel);

      _networkListCubit.setNetworkStatusModel(networkStatusModel: networkStatusModel);
      _updateNetworkStatusModelList(ignoreNetworkUnknownModel: networkUnknownModel);

      bool networkUnchangedBool = networkStatusModel.uri == state.networkStatusModel.uri;
      if (networkUnchangedBool) {
        await _networkCustomSectionCubit.updateNetworks(networkStatusModel);
        emit(NetworkModuleState.connected(networkStatusModel));
        await _checkIfSignOutNeeded();
      }
    }

    await _networkCustomSectionCubit.refreshNetworks();
  }

  Future<void> _mapAutoConnectEventToState(NetworkModuleAutoConnectEvent networkModuleAutoConnectEvent, Emitter<NetworkModuleState> emit) async {
    NetworkUnknownModel networkUnknownModel = networkModuleAutoConnectEvent.networkUnknownModel;
    emit(NetworkModuleState.connecting(networkUnknownModel));

    if (initializationCompleter.isCompleted == false) {
      initializationCompleter.complete();
    }
    ANetworkStatusModel networkStatusModel = await _networkModuleService.getNetworkStatusModel(networkUnknownModel);
    _networkListCubit.setNetworkStatusModel(networkStatusModel: networkStatusModel);

    bool networkUnchangedBool = NetworkUtils.compareUrisByUrn(networkStatusModel.uri, state.networkStatusModel.uri);

    if (networkUnchangedBool) {
      _rpcBrowserUrlController.setRpcAddress(networkStatusModel);
      await _networkCustomSectionCubit.updateNetworks(networkStatusModel);
      emit(NetworkModuleState.connected(networkStatusModel));
    } else {
      await _networkCustomSectionCubit.updateNetworks();
    }
  }

  Future<void> _mapConnectEventToState(NetworkModuleConnectEvent networkModuleConnectEvent, Emitter<NetworkModuleState> emit) async {
    ANetworkOnlineModel networkOnlineModel = networkModuleConnectEvent.networkOnlineModel;
    _rpcBrowserUrlController.setRpcAddress(networkOnlineModel);
    await _networkCustomSectionCubit.updateNetworks(networkOnlineModel);
    emit(NetworkModuleState.connected(networkOnlineModel));
    await _checkIfSignOutNeeded();
  }

  Future<void> _mapDisconnectEventToState(
    NetworkModuleDisconnectEvent networkModuleDisconnectEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    _rpcBrowserUrlController.removeRpcAddress();
    await _networkCustomSectionCubit.updateNetworks(null);
    emit(NetworkModuleState.disconnected());
  }

  Future<void> _checkIfSignOutNeeded() async {
    AuthCubit authCubit = globalLocator<AuthCubit>();
    bool signedInBool = authCubit.state != null;
    if (state.valuesFromNetworkExistBool == false && signedInBool) {
      await authCubit.signOut();
    }
  }

  void _updateNetworkStatusModelList({NetworkUnknownModel? ignoreNetworkUnknownModel}) {
    List<ANetworkStatusModel> networkStatusModelList = _networkListCubit.networkStatusModelList;
    for (ANetworkStatusModel networkStatusModel in networkStatusModelList) {
      bool networkNotIgnoredBool = networkStatusModel.uri != ignoreNetworkUnknownModel?.uri;
      if (networkNotIgnoredBool && networkStatusModel.connectionStatusType != ConnectionStatusType.refreshing) {
        _updateNetworkStatusModel(networkUnknownModel: NetworkUnknownModel.fromNetworkStatusModel(networkStatusModel));
      }
    }
  }

  Future<void> _updateNetworkStatusModel({required NetworkUnknownModel networkUnknownModel}) async {
    ANetworkStatusModel networkStatusModel = await _networkModuleService.getNetworkStatusModel(networkUnknownModel);
    _networkListCubit.setNetworkStatusModel(networkStatusModel: networkStatusModel);
  }
}
