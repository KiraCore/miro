import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network/a_network_event.dart';
import 'package:miro/blocs/specific_blocs/network/a_network_state.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network/states/a_network_connectable_state.dart';
import 'package:miro/blocs/specific_blocs/network/states/network_connected_state.dart';
import 'package:miro/blocs/specific_blocs/network/states/network_connecting_state.dart';
import 'package:miro/blocs/specific_blocs/network/states/network_disconnected_state.dart';
import 'package:miro/blocs/specific_blocs/network/utils/network_browser_url_utils.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_utils_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkBloc extends Bloc<ANetworkEvent, ANetworkState> {
  final NetworkUtilsService networkUtilsService = globalLocator<NetworkUtilsService>();

  NetworkBloc() : super(NetworkDisconnectedState()) {
    on<NetworkConnectFromUrlEvent>(_mapNetworkConnectFromUrlEventToState);
    on<NetworkConnectEvent>(_mapNetworkConnectEventToState);
    on<NetworkSetUpEvent>(_mapNetworkSetUpEventToState);
    on<NetworkDisconnectEvent>(_mapNetworkDisconnectEventToState);
    add(const NetworkConnectFromUrlEvent());
  }

  bool get isConnected {
    return connectedNetworkStatusModel != null;
  }

  Uri? get connectedNetworkUri {
    return connectedNetworkStatusModel?.uri;
  }

  ANetworkStatusModel? get connectedNetworkStatusModel {
    if (state is ANetworkConnectableState) {
      return (state as ANetworkConnectableState).networkStatusModel;
    }
    return null;
  }

  Future<void> _mapNetworkConnectFromUrlEventToState(
    NetworkConnectFromUrlEvent networkConnectFromUrlEvent,
    Emitter<ANetworkState> emit,
  ) async {
    String? networkAddress = NetworkBrowserUrlUtils.getNetworkAddress();
    if (networkAddress == null) {
      return;
    }
    Uri uri = NetworkUtils.parseUrl(networkAddress);
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: uri);
    add(NetworkConnectEvent(networkUnknownModel));
  }

  Future<void> _mapNetworkConnectEventToState(
    NetworkConnectEvent networkConnectEvent,
    Emitter<ANetworkState> emit,
  ) async {
    NetworkUnknownModel networkUnknownModel = networkConnectEvent.networkUnknownModel;
    emit(NetworkConnectingState(networkUnknownModel: networkUnknownModel));
    ANetworkStatusModel networkStatusModel = await networkUtilsService.getNetworkStatusModel(networkUnknownModel);

    if (networkStatusModel is ANetworkOnlineModel) {
      add(NetworkSetUpEvent(networkStatusModel, connectingStateRequired: networkConnectEvent.avoidMultipleRequests));
    } else {
      add(NetworkDisconnectEvent());
    }
  }

  Future<void> _mapNetworkSetUpEventToState(NetworkSetUpEvent networkSetUpEvent, Emitter<ANetworkState> emit) async {
    // Avoid multiple connection requests
    bool ignoreEvent = networkSetUpEvent.connectingStateRequired && state is! NetworkConnectingState;
    if (ignoreEvent) {
      return;
    }
    ANetworkOnlineModel networkOnlineModel = networkSetUpEvent.networkOnlineModel;
    NetworkBrowserUrlUtils.addNetworkAddress(networkOnlineModel);
    emit(NetworkConnectedState(networkOnlineModel: networkOnlineModel));
  }

  Future<void> _mapNetworkDisconnectEventToState(
    NetworkDisconnectEvent networkDisconnectEvent,
    Emitter<ANetworkState> emit,
  ) async {
    NetworkBrowserUrlUtils.removeNetworkAddress();
    emit(NetworkDisconnectedState());
  }
}
