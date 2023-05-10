import 'package:flutter/material.dart';
import 'package:miro/blocs/layout/drawer/a_drawer_state.dart';

class DrawerVisibleState extends ADrawerState {
  final bool canPop;
  final Widget currentRoute;

  DrawerVisibleState({
    required this.canPop,
    required this.currentRoute,
  });

  @override
  List<Object?> get props => <Object?>[currentRoute, canPop];
}
