import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_state.dart';

class NavMenuCubit extends Cubit<NavMenuState> {
  NavMenuCubit() : super(const NavMenuState.empty());

  void updateRouteName(String path) {
    emit(NavMenuState(selectedRouteName: path));
  }
}
