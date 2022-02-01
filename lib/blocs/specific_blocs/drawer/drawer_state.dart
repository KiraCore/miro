part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class DrawerNoRouteState extends DrawerState {}


class DrawerNavigate extends DrawerState {
  final Widget currentRoute;
  final bool canPop;

  DrawerNavigate({required this.currentRoute, required this.canPop});

  @override
  List<Object?> get props => <Object?>[currentRoute, canPop];
}

class NetworkConnectorErrorState extends DrawerState {}
