import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/shared/utils/string_utils.dart';

class NetworkCustomSectionCubit extends Cubit<NetworkCustomSectionState> {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final NetworkModuleService _networkModuleService = globalLocator<NetworkModuleService>();

  String _activeStateId = StringUtils.generateUuid();

  NetworkCustomSectionCubit() : super(NetworkCustomSectionState());

  Future<void> checkConnection(Uri uri) async {
    NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
      uri: uri,
      connectionStatusType: ConnectionStatusType.disconnected,
      lastRefreshDateTime: DateTime.now(),
      tokenDefaultDenomModel: TokenDefaultDenomModel.empty(),
    );
    bool networkCustomBool = _isNetworkCustom(networkUnknownModel);

    if (networkCustomBool == false || state.containsUriWithEqualUrn(uri)) {
      return;
    }

    networkUnknownModel = _appConfig.findNetworkModelInConfig(networkUnknownModel);
    emit(state.copyWith(checkedNetworkStatusModel: networkUnknownModel));

    await refreshNetworks();
  }

  Future<void> refreshNetworks() async {
    String stateId = StringUtils.generateUuid();
    _activeStateId = stateId;

    ANetworkStatusModel? newCheckedNetworkStatusModel;
    ANetworkStatusModel? newLastConnectedNetworkStatusModel;

    if (state.checkedNetworkStatusModel?.connectionStatusType != ConnectionStatusType.refreshing) {
      newCheckedNetworkStatusModel = await _refreshCustomNetwork(state.checkedNetworkStatusModel);
    }

    if (state.lastConnectedNetworkStatusModel?.connectionStatusType != ConnectionStatusType.refreshing) {
      newLastConnectedNetworkStatusModel = await _refreshCustomNetwork(state.lastConnectedNetworkStatusModel);
    }

    bool stateIdEqualBool = stateId == _activeStateId;
    if (stateIdEqualBool) {
      emit(
        state.copyWith(
          checkedNetworkStatusModel: newCheckedNetworkStatusModel,
          lastConnectedNetworkStatusModel: newLastConnectedNetworkStatusModel,
          expandedBool: state.expandedBool,
        ),
      );
    }
  }

  Future<void> updateNetworks([ANetworkStatusModel? connectedNetworkStatusModel]) async {
    bool customNetworkBool = _isNetworkCustom(connectedNetworkStatusModel);
    bool differentNetworkBool = NetworkUtils.compareUrisByUrn(connectedNetworkStatusModel?.uri, state.connectedNetworkStatusModel?.uri) == false;
    bool checkedNetworkBool = NetworkUtils.compareUrisByUrn(connectedNetworkStatusModel?.uri, state.checkedNetworkStatusModel?.uri);
    bool customNetworkConnectedBool = state.connectedNetworkStatusModel != null;

    if (customNetworkBool) {
      _activeStateId = StringUtils.generateUuid();
    }

    emit(
      NetworkCustomSectionState(
        connectedNetworkStatusModel: customNetworkBool ? connectedNetworkStatusModel : null,
        expandedBool: state.expandedBool,
        checkedNetworkStatusModel: checkedNetworkBool ? null : state.checkedNetworkStatusModel,
        lastConnectedNetworkStatusModel: differentNetworkBool && customNetworkConnectedBool
            ? state.connectedNetworkStatusModel?.copyWith(connectionStatusType: ConnectionStatusType.disconnected)
            : state.lastConnectedNetworkStatusModel?.copyWith(connectionStatusType: ConnectionStatusType.disconnected),
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

  bool _isNetworkCustom(ANetworkStatusModel? networkStatusModel) {
    if (networkStatusModel == null) {
      return false;
    }
    List<NetworkUnknownModel> matchingNetworkUnknownModels =
        _appConfig.networkList.where((NetworkUnknownModel e) => NetworkUtils.compareUrisByUrn(e.uri, networkStatusModel.uri)).toList();
    return matchingNetworkUnknownModels.isEmpty;
  }

  Future<ANetworkStatusModel?> _refreshCustomNetwork(ANetworkStatusModel? networkStatusModel) async {
    if (networkStatusModel == null) {
      return null;
    }

    NetworkUnknownModel networkUnknownModel =
        (networkStatusModel is NetworkUnknownModel) ? networkStatusModel : NetworkUnknownModel.fromNetworkStatusModel(networkStatusModel);

    ANetworkStatusModel refreshedNetworkStatusModel = await _networkModuleService.getNetworkStatusModel(
        networkUnknownModel.copyWith(uri: networkUnknownModel.uri.replace(scheme: 'https')),
        previousNetworkUnknownModel: networkUnknownModel);

    return refreshedNetworkStatusModel;
  }
}
