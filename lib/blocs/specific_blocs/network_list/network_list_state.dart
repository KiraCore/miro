part of 'network_list_cubit.dart';

abstract class NetworkListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class NetworkListInitialState extends NetworkListState {}

class NetworkListLoadingState extends NetworkListState {}

class NetworkListLoadedState extends NetworkListState {
  final List<NetworkModel> networkList;

  NetworkListLoadedState({required this.networkList});

  @override
  List<Object> get props => <Object>[networkList];
}

class NetworkListErrorState extends NetworkListState {}
