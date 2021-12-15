part of 'network_connector_cubit.dart';

abstract class NetworkConnectorState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkConnectorInitialState extends NetworkConnectorState {}

class NetworkConnectorConnectingState extends NetworkConnectorState {}

class NetworkConnectorConnectedState extends NetworkConnectorState {
  final NetworkModel currentNetwork;

  NetworkConnectorConnectedState({required this.currentNetwork});

  @override
  List<Object> get props => <Object>[currentNetwork];
}

class NetworkConnectorErrorState extends NetworkConnectorState {}
