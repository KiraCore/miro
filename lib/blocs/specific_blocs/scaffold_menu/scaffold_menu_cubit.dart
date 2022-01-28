import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scaffold_menu_state.dart';

class ScaffoldMenuCubit extends Cubit<ScaffoldMenuState> {

  ScaffoldMenuCubit() : super(ScaffoldMenuChangedRoute(routePath: 'dashboard'));

  Future<void> updateRoutePath(String path) async {
    emit(ScaffoldMenuChangedRoute(routePath: path));
  }
}
