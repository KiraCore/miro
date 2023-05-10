import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/utils/string_utils.dart';

class NetworkCustomSectionCubit extends Cubit<NetworkCustomSectionState> {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final NetworkModuleService _networkModuleService = globalLocator<NetworkModuleService>();

  String _activeStateId = StringUtils.generateUuid();

  NetworkCustomSectionCubit() : super(NetworkCustomSectionState());

  Future<void> checkConnection(Uri uri) async {
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: uri, connectionStatusType: ConnectionStatusType.disconnected);
    bool isCustomNetwork = _checkIsCustomNetwork(networkUnknownModel);

    if (isCustomNetwork == false || state.containsUri(uri)) {
      return;
    }

    String stateId = StringUtils.generateUuid();
    _activeStateId = stateId;

    networkUnknownModel = _appConfig.findNetworkModelInConfig(networkUnknownModel);
    emit(state.copyWith(checkedNetworkStatusModel: networkUnknownModel));
    ANetworkStatusModel networkStatusModel = await _networkModuleService.getNetworkStatusModel(networkUnknownModel);

    bool isStateIdEqual = stateId == _activeStateId;
    if (isStateIdEqual) {
      emit(state.copyWith(checkedNetworkStatusModel: networkStatusModel));
    }
  }

  Future<void> updateAfterNetworkConnect(ANetworkStatusModel? connectedNetworkStatusModel) async {
    if (connectedNetworkStatusModel == null) {
      _activeStateId = StringUtils.generateUuid();
      emit(NetworkCustomSectionState());
      return;
    }

    bool isCustomNetwork = _checkIsCustomNetwork(connectedNetworkStatusModel);
    bool isNetworkRefreshed = state.connectedNetworkStatusModel?.uri.host == connectedNetworkStatusModel.uri.host;

    if (isNetworkRefreshed) {
      emit(state.copyWith(connectedNetworkStatusModel: connectedNetworkStatusModel));
    } else if (isCustomNetwork) {
      _activeStateId = StringUtils.generateUuid();
      emit(NetworkCustomSectionState(connectedNetworkStatusModel: connectedNetworkStatusModel));
    }
  }

  bool _checkIsCustomNetwork(ANetworkStatusModel networkStatusModel) {
    List<NetworkUnknownModel> matchingNetworkUnknownModels =
        _appConfig.networkList.where((NetworkUnknownModel e) => e.uri.host == networkStatusModel.uri.host).toList();
    return matchingNetworkUnknownModels.isEmpty;
  }
}
