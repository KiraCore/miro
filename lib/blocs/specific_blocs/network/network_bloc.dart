import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network/a_network_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network/network_state.dart';
import 'package:miro/blocs/specific_blocs/network/utils/network_browser_url_utils.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_utils_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkBloc extends Bloc<ANetworkEvent, NetworkState> {
  final NetworkUtilsService networkUtilsService = globalLocator<NetworkUtilsService>();

  NetworkBloc() : super(const NetworkState.disconnected()) {
    on<NetworkConnectFromUrlEvent>(_mapNetworkConnectFromUrlEventToState);
    on<NetworkConnectEvent>(_mapNetworkConnectEventToState);
    on<NetworkSetUpEvent>(_mapNetworkSetUpEventToState);
    on<NetworkDisconnectEvent>(_mapNetworkDisconnectEventToState);
    add(const NetworkConnectFromUrlEvent());
  }

  Future<void> _mapNetworkConnectFromUrlEventToState(
    NetworkConnectFromUrlEvent networkConnectFromUrlEvent,
    Emitter<NetworkState> emit,
  ) async {
    String? networkAddress = NetworkBrowserUrlUtils.getNetworkAddress(
      optionalNetworkUri: networkConnectFromUrlEvent.optionalNetworkUri,
    );
    if (networkAddress == null) {
      return;
    }
    Uri uri = NetworkUtils.parseUrl(networkAddress);
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: uri);
    add(NetworkConnectEvent(networkUnknownModel, avoidMultipleRequests: true));
  }

  Future<void> _mapNetworkConnectEventToState(
    NetworkConnectEvent networkConnectEvent,
    Emitter<NetworkState> emit,
  ) async {
    NetworkUnknownModel networkUnknownModel = networkConnectEvent.networkUnknownModel;
    emit(NetworkState.connecting(networkUnknownModel));
    ANetworkStatusModel networkStatusModel = await networkUtilsService.getNetworkStatusModel(networkUnknownModel);

    if (networkStatusModel is ANetworkOnlineModel) {
      add(NetworkSetUpEvent(networkStatusModel, connectingStateRequired: networkConnectEvent.avoidMultipleRequests));
    } else {
      add(NetworkDisconnectEvent());
    }
  }

  Future<void> _mapNetworkSetUpEventToState(NetworkSetUpEvent networkSetUpEvent, Emitter<NetworkState> emit) async {
    // Avoid multiple connection requests
    bool ignoreEvent = networkSetUpEvent.connectingStateRequired && !state.isConnecting;
    if (ignoreEvent) {
      return;
    }
    ANetworkOnlineModel networkOnlineModel = networkSetUpEvent.networkOnlineModel;
    NetworkBrowserUrlUtils.addNetworkAddress(networkOnlineModel);
    emit(NetworkState.connected(networkOnlineModel));
  }

  Future<void> _mapNetworkDisconnectEventToState(
    NetworkDisconnectEvent networkDisconnectEvent,
    Emitter<NetworkState> emit,
  ) async {
    NetworkBrowserUrlUtils.removeNetworkAddress();
    emit(const NetworkState.disconnected());
  }
}
