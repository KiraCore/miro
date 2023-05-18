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
    bool networkCustomBool = _isNetworkCustom(networkUnknownModel);

    if (networkCustomBool == false || state.containsUri(uri)) {
      return;
    }

    String stateId = StringUtils.generateUuid();
    _activeStateId = stateId;

    networkUnknownModel = _appConfig.findNetworkModelInConfig(networkUnknownModel);
    emit(state.copyWith(checkedNetworkStatusModel: networkUnknownModel));
    ANetworkStatusModel networkStatusModel = await _networkModuleService.getNetworkStatusModel(networkUnknownModel);

    bool stateIdEqualBool = stateId == _activeStateId;
    if (stateIdEqualBool) {
      emit(state.copyWith(checkedNetworkStatusModel: networkStatusModel));
    }
  }

  Future<void> updateAfterNetworkConnect(ANetworkStatusModel? connectedNetworkStatusModel) async {
    if (connectedNetworkStatusModel == null) {
      _activeStateId = StringUtils.generateUuid();
      emit(NetworkCustomSectionState(expandedBool: state.expandedBool));
      return;
    }

    bool customNetworkBool = _isNetworkCustom(connectedNetworkStatusModel);
    bool differentNetworkBool = connectedNetworkStatusModel.uri.host != state.connectedNetworkStatusModel?.uri.host;
    bool checkedNetworkBool = connectedNetworkStatusModel.uri.host == state.checkedNetworkStatusModel?.uri.host;
    bool customNetworkConnectedBool = state.connectedNetworkStatusModel != null;

    if (customNetworkBool) {
      _activeStateId = StringUtils.generateUuid();
    }
    emit(
      NetworkCustomSectionState(
        connectedNetworkStatusModel: customNetworkBool ? connectedNetworkStatusModel : null,
        expandedBool: state.expandedBool,
        checkedNetworkStatusModel: checkedNetworkBool ? null : state.checkedNetworkStatusModel,
        lastConnectedNetworkStatusModel:
            differentNetworkBool && customNetworkConnectedBool ? state.connectedNetworkStatusModel : state.lastConnectedNetworkStatusModel,
      ),
    );
  }

  void updateSwitchValue({required bool? expandedBool}) {
    emit(state.copyWith(expandedBool: expandedBool));
  }

  void resetSwitchValueWhenConnected() {
    if (state.connectedNetworkStatusModel != null) {
      emit(state.copyWith(expandedBool: null));
    }
  }

  bool _isNetworkCustom(ANetworkStatusModel networkStatusModel) {
    List<NetworkUnknownModel> matchingNetworkUnknownModels =
        _appConfig.networkList.where((NetworkUnknownModel e) => e.uri.host == networkStatusModel.uri.host).toList();
    return matchingNetworkUnknownModels.isEmpty;
  }
}
