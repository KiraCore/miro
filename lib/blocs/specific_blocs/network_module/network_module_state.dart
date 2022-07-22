import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkModuleState extends Equatable {
  final ANetworkStatusModel? networkStatusModel;

  const NetworkModuleState.connecting(NetworkUnknownModel networkUnknownModel)
      : networkStatusModel = networkUnknownModel;

  const NetworkModuleState.connected(ANetworkOnlineModel networkOnlineModel) : networkStatusModel = networkOnlineModel;

  const NetworkModuleState.disconnected() : networkStatusModel = null;

  bool get isConnected => networkStatusModel is ANetworkOnlineModel;

  bool get isConnecting => networkStatusModel is NetworkUnknownModel;

  bool get hasUri => networkStatusModel != null;

  Uri? get networkUri => networkStatusModel?.uri;

  @override
  List<Object?> get props => <Object?>[networkStatusModel];
}
