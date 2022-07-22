import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/a_network_module_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/blocs/specific_blocs/network_module/utils/network_browser_url_utils.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkModuleBloc extends Bloc<ANetworkModuleEvent, NetworkModuleState> {
  final NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();

  NetworkModuleBloc() : super(const NetworkModuleState.disconnected()) {
    on<NetworkModuleConnectFromUrlEvent>(_mapNetworkModuleConnectFromUrlEventToState);
    on<NetworkModuleConnectEvent>(_mapNetworkModuleConnectEventToState);
    on<NetworkModuleSetUpEvent>(_mapNetworkModuleSetUpEventToState);
    on<NetworkModuleDisconnectEvent>(_mapNetworkModuleDisconnectEventToState);
    add(const NetworkModuleConnectFromUrlEvent());
  }

  Future<void> _mapNetworkModuleConnectFromUrlEventToState(
    NetworkModuleConnectFromUrlEvent networkModuleConnectFromUrlEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    String? networkAddress = NetworkBrowserUrlUtils.getNetworkAddress(
      optionalNetworkUri: networkModuleConnectFromUrlEvent.optionalNetworkUri,
    );
    if (networkAddress == null) {
      return;
    }
    Uri uri = NetworkUtils.parseUrl(networkAddress);
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: uri);
    add(NetworkModuleConnectEvent(networkUnknownModel, avoidMultipleRequests: true));
  }

  Future<void> _mapNetworkModuleConnectEventToState(
    NetworkModuleConnectEvent networkModuleConnectEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    NetworkUnknownModel networkUnknownModel = networkModuleConnectEvent.networkUnknownModel;
    emit(NetworkModuleState.connecting(networkUnknownModel));
    ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(networkUnknownModel);

    if (networkStatusModel is ANetworkOnlineModel) {
      add(NetworkModuleSetUpEvent(
        networkStatusModel,
        connectingStateRequired: networkModuleConnectEvent.avoidMultipleRequests,
      ));
    } else {
      add(NetworkModuleDisconnectEvent());
    }
  }

  Future<void> _mapNetworkModuleSetUpEventToState(
    NetworkModuleSetUpEvent networkModuleSetUpEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    // Avoid multiple connection requests
    bool ignoreEvent = networkModuleSetUpEvent.connectingStateRequired && !state.isConnecting;
    if (ignoreEvent) {
      return;
    }
    ANetworkOnlineModel networkOnlineModel = networkModuleSetUpEvent.networkOnlineModel;
    NetworkBrowserUrlUtils.addNetworkAddress(networkOnlineModel);
    emit(NetworkModuleState.connected(networkOnlineModel));
  }

  Future<void> _mapNetworkModuleDisconnectEventToState(
    NetworkModuleDisconnectEvent networkModuleDisconnectEvent,
    Emitter<NetworkModuleState> emit,
  ) async {
    NetworkBrowserUrlUtils.removeNetworkAddress();
    emit(const NetworkModuleState.disconnected());
  }
}
