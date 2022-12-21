import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/drawer/a_drawer_state.dart';

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
