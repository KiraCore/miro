import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/controllers/loading_timer_controller.dart';
import 'package:miro/blocs/pages/loading/loading_page/loading_page_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_connected_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_connecting_state.dart';
import 'package:miro/blocs/pages/loading/loading_page/states/loading_page_disconnected_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

class LoadingPageCubit extends Cubit<ALoadingPageState> {
  late final LoadingTimerController loadingTimerController = LoadingTimerController(onTimeExpired: _handleLoadingTimerExpired);
  final ValueNotifier<bool> cancelButtonEnabledNotifier = ValueNotifier<bool>(false);

  final NetworkModuleBloc _networkModuleBloc;
  late final StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;

  LoadingPageCubit({
    NetworkModuleBloc? networkModuleBloc,
  })  : _networkModuleBloc = networkModuleBloc ?? globalLocator<NetworkModuleBloc>(),
        super(const LoadingPageConnectingState()) {
    _init();
  }

  @override
  Future<void> close() {
    loadingTimerController.dispose();
    _networkModuleStateSubscription.cancel();
    cancelButtonEnabledNotifier.dispose();
    return super.close();
  }

  void cancelConnection() {
    _networkModuleBloc.add(NetworkModuleDisconnectEvent());
  }

  Future<void> _init() async {
    await _networkModuleBloc.initializationCompleter.future;

    emit(LoadingPageConnectingState(networkStatusModel: _networkModuleBloc.state.networkStatusModel));
    _networkModuleStateSubscription = _networkModuleBloc.stream.listen(_handleNetworkModuleStateChanged);
  }

  void _handleLoadingTimerExpired() {
    cancelButtonEnabledNotifier.value = true;
  }

  Future<void> _handleNetworkModuleStateChanged(NetworkModuleState networkModuleState) async {
    await loadingTimerController.loadingCompleter.future;
    ANetworkStatusModel networkStatusModel = networkModuleState.networkStatusModel;

    if (networkStatusModel is NetworkHealthyModel) {
      emit(LoadingPageConnectedState(networkStatusModel: networkStatusModel));
    } else {
      _networkModuleBloc.add(NetworkModuleDisconnectEvent());

      ConnectionErrorType? connectionErrorType;

      if (networkStatusModel is NetworkUnhealthyModel) {
        connectionErrorType = ConnectionErrorType.serverUnhealthy;
      } else if (networkStatusModel is NetworkOfflineModel) {
        connectionErrorType = ConnectionErrorType.serverOffline;
      }

      emit(LoadingPageDisconnectedState(
        networkStatusModel: networkStatusModel,
        connectionErrorType: connectionErrorType,
      ));
    }
    await close();
  }
}
