import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/layout/drawer/a_drawer_state.dart';
import 'package:miro/blocs/layout/drawer/states/drawer_hidden_state.dart';
import 'package:miro/blocs/layout/drawer/states/drawer_visible_state.dart';

class DrawerCubit extends Cubit<ADrawerState> {
  final List<Widget> routeHistory = List<Widget>.empty(growable: true);

  DrawerCubit() : super(DrawerHiddenState());

  void replace(GlobalKey<ScaffoldState> scaffoldKey, Widget route) {
    bool? drawerOpen = _isDrawerOpen(scaffoldKey);
    if (drawerOpen == false) {
      navigate(scaffoldKey, route);
    } else {
      routeHistory
        ..removeLast()
        ..add(route);
      emit(DrawerVisibleState(currentRoute: route, canPop: canPop));
    }
  }

  void navigate(GlobalKey<ScaffoldState> scaffoldKey, Widget route) {
    bool? drawerOpen = _isDrawerOpen(scaffoldKey);
    if (drawerOpen == false) {
      _resetRouteHistory();
      scaffoldKey.currentState!.openEndDrawer();
    }
    routeHistory.add(route);
    emit(DrawerVisibleState(currentRoute: route, canPop: canPop));
  }

  void pop(GlobalKey<ScaffoldState> scaffoldKey) {
    if (routeHistory.isNotEmpty) {
      routeHistory.removeLast();
      Widget route = routeHistory.last;
      emit(DrawerVisibleState(currentRoute: route, canPop: canPop));
    } else {
      closeDrawer(scaffoldKey);
    }
  }

  void closeDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
    bool? drawerOpen = _isDrawerOpen(scaffoldKey);
    if (drawerOpen == true) {
      Navigator.pop(scaffoldKey.currentContext!);
    }
    _resetRouteHistory();
    emit(DrawerHiddenState());
  }

  bool get canPop => routeHistory.length > 1;

  bool? _isDrawerOpen(GlobalKey<ScaffoldState> scaffoldKey) {
    ScaffoldState? scaffoldState = scaffoldKey.currentState;
    return scaffoldState?.isEndDrawerOpen;
  }

  void _resetRouteHistory() {
    routeHistory.clear();
  }
}
