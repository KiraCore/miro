part of 'network_list_cubit.dart';

abstract class NetworkListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkListInitialState extends NetworkListState {}

class NetworkListLoadingState extends NetworkListState {}

class NetworkListLoadedState extends NetworkListState {
  final List<NetworkModel> networkList;
  final DateTime lastUpdateTime;

  NetworkListLoadedState({required this.networkList}) : lastUpdateTime = DateTime.now();

  @override
  List<Object> get props => <Object>[networkList, lastUpdateTime];
}

class NetworkListErrorState extends NetworkListState {}
