import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerNoRouteState());

  List<Widget> pagesHistory = List<Widget>.empty(growable: true);

  bool get canPop => pagesHistory.length > 1;

  void navigate(GlobalKey<ScaffoldState>? scaffoldKey, Widget route) {
    if (scaffoldKey != null && !scaffoldKey.currentState!.isEndDrawerOpen) {
      _resetRouteHistory();
      scaffoldKey.currentState!.openEndDrawer();
    }
    pagesHistory.add(route);
    emit(DrawerNavigate(currentRoute: route, canPop: canPop));
  }

  void replace(GlobalKey<ScaffoldState>? scaffoldKey, Widget route) {
    if (scaffoldKey != null && !scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.openEndDrawer();
    }
    pagesHistory
      ..removeLast()
      ..add(route);
    emit(DrawerNavigate(currentRoute: route, canPop: canPop));
  }

  void pop(GlobalKey<ScaffoldState>? scaffoldKey) {
    if (pagesHistory.isNotEmpty) {
      pagesHistory.removeLast();
      Widget route = pagesHistory.last;
      emit(DrawerNavigate(currentRoute: route, canPop: canPop));
    } else {
      closeDrawer(scaffoldKey);
    }
  }

  void closeDrawer(GlobalKey<ScaffoldState>? scaffoldKey) {
    if (scaffoldKey != null && scaffoldKey.currentState!.isEndDrawerOpen) {
      Navigator.pop(scaffoldKey.currentContext!);
    }
    _resetRouteHistory();
    emit(DrawerNoRouteState());
  }

  void _resetRouteHistory() {
    pagesHistory = List<Widget>.empty(growable: true);
  }
}
