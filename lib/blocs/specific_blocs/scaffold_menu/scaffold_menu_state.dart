part of 'scaffold_menu_cubit.dart';

abstract class ScaffoldMenuState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class ScaffoldMenuChangedRoute extends ScaffoldMenuState {
  final String routePath;

  ScaffoldMenuChangedRoute({required this.routePath});

  @override
  List<Object> get props => <Object>[routePath];
}
