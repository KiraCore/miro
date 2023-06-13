import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/a_visualizer_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_error_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_loaded_state.dart';
import 'package:miro/blocs/pages/menu/visualizer/states/visualizer_loading_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/services/api/query_visualizer_service.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

class VisualizerCubit extends Cubit<AVisualizerState> {
  final QueryVisualizerService queryVisualizerService = globalLocator<QueryVisualizerService>();
  final PageReloadController pageReloadController = PageReloadController();
  final NetworkModuleBloc _networkModuleBloc;
  late final StreamSubscription<NetworkModuleState> _networkModuleStateSubscription;

  VisualizerCubit({
    NetworkModuleBloc? networkModuleBloc,
  })  : _networkModuleBloc = networkModuleBloc ?? globalLocator<NetworkModuleBloc>(),
        super(VisualizerLoadingState()) {
    _networkModuleStateSubscription = _networkModuleBloc.stream.listen((_) => _refresh());
    _refresh();
  }

  @override
  Future<void> close() {
    _networkModuleStateSubscription.cancel();
    return super.close();
  }

  List<String> getUniqueCountries() {
    List<VisualizerNodeModel> nodeList = state.visualizerNodeModelList ?? <VisualizerNodeModel>[];
    List<String> uniqueCountries = nodeList.map((VisualizerNodeModel visualizerNodeModel) => visualizerNodeModel.countryLatLongModel.country).toSet().toList();
    return uniqueCountries;
  }

  Future<void> _refresh() async {
    ANetworkStatusModel networkStatusModel = _networkModuleBloc.state.networkStatusModel;
    bool changedNetwork = networkStatusModel.uri != pageReloadController.usedUri;
    pageReloadController.handleReloadCall(networkStatusModel);
    int localReloadId = pageReloadController.activeReloadId;

    if (changedNetwork) {
      emit(VisualizerLoadingState());
    }

    try {
      PageData<VisualizerNodeModel> visualizerNodeModelData = await queryVisualizerService.getVisualizerNodeModelList(
        const QueryP2PReq(
          // TODO(Marcin): change those parameters after endpoit implementation
          offset: 0,
          limit: 100,
        ),
      );
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete) {
        emit(VisualizerLoadedState(visualizerNodeModelList: visualizerNodeModelData.listItems));
      }
    } catch (_) {
      AppLogger().log(message: 'Cannot get nodeList');
      bool canReloadComplete = pageReloadController.canReloadComplete(localReloadId);
      if (canReloadComplete && changedNetwork) {
        emit(VisualizerErrorState());
      }
    }
  }
}
