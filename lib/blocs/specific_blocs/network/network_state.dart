import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkState extends Equatable {
  final ANetworkStatusModel? networkStatusModel;

  const NetworkState.connecting(NetworkUnknownModel networkUnknownModel) : networkStatusModel = networkUnknownModel;

  const NetworkState.connected(ANetworkOnlineModel networkOnlineModel) : networkStatusModel = networkOnlineModel;

  const NetworkState.disconnected() : networkStatusModel = null;

  bool get isConnected => networkStatusModel is ANetworkOnlineModel;

  bool get isConnecting => networkStatusModel is NetworkUnknownModel;

  bool get hasUri => networkStatusModel != null;

  Uri? get networkUri => networkStatusModel?.uri;

  @override
  List<Object?> get props => <Object?>[networkStatusModel];
}
