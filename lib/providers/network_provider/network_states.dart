import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/network_model.dart';

abstract class NetworkState extends Equatable {
  @override
  List<Object?> get props => <Object>[];
}

class ConnectingNetworkState extends NetworkState {
  final NetworkModel networkModel;

  ConnectingNetworkState(this.networkModel);

  @override
  List<Object?> get props => <Object>[networkModel.hashCode];
}

class ConnectedNetworkState extends NetworkState {
  final NetworkModel networkModel;

  ConnectedNetworkState(this.networkModel);

  @override
  List<Object?> get props => <Object>[networkModel.hashCode];
}

class DisconnectedNetworkState extends NetworkState {}
