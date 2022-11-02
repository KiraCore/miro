import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/dashboard/a_dashboard_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_error_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_loaded_state.dart';
import 'package:miro/blocs/specific_blocs/dashboard/states/dashboard_loading_state.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

class DashboardCubit extends Cubit<ADashboardState> {
  final DashboardService dashboardService = globalLocator<DashboardService>();

  late final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  late final StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;
  final PageReloadController pageReloadController = PageReloadController();

  DashboardCubit() : super(DashboardLoadingState()) {
    _init();
  }

  @override
  Future<void> close() async {
    await _networkModuleStateSubscription.cancel();
    await super.close();
  }

  Future<void> _init() async {
    _networkModuleStateSubscription = networkModuleBloc.stream.listen(_reloadAfterNetworkModuleStateChanged);
    await _reload();
  }

  void _reloadAfterNetworkModuleStateChanged(NetworkModuleState networkModuleState) {
    bool isNetworkOnline = networkModuleState.networkStatusModel is ANetworkOnlineModel;
    if (isNetworkOnline) {
      _reload();
    }
  }

  Future<void> _reload() async {
    ANetworkStatusModel networkStatusModel = networkModuleBloc.state.networkStatusModel;
    bool changedNetwork = networkStatusModel.uri != pageReloadController.usedUri;
    pageReloadController.handleReloadCall(networkStatusModel);
    int localReloadId = pageReloadController.activeReloadId;

    if (networkStatusModel is NetworkOfflineModel) {
      emit(DashboardErrorState());
      return;
    } else if (changedNetwork) {
      emit(DashboardLoadingState());
    }

    try {
      DashboardModel dashboardModel = await dashboardService.getDashboardModel();
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete) {
        emit(DashboardLoadedState(dashboardModel: dashboardModel));
      }
    } catch (e) {
      AppLogger().log(message: 'Cannot update dashboard');
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete && changedNetwork) {
        emit(DashboardErrorState());
      }
    }
  }
}
