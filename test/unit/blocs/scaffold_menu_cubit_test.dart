import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/scaffold_menu/scaffold_menu_cubit.dart';

void main() {
  ScaffoldMenuCubit scaffoldMenuCubit = ScaffoldMenuCubit();

  group('Tests of ScaffoldMenuCubit initial state', () {
    test('Should return ScaffoldMenuChangedRoute with route name defined as default', () {
      expect(
        scaffoldMenuCubit.state,
          ScaffoldMenuChangedRoute(routePath: 'dashboard'),
      );
    });
  });

  group('Tests of ScaffoldMenuCubit.updateRoutePath() state', () {
    test('Should return ScaffoldMenuChangedRoute with provided route name', () {
      scaffoldMenuCubit.updateRoutePath('accounts');
      expect(
        scaffoldMenuCubit.state,
        ScaffoldMenuChangedRoute(routePath: 'accounts'),
      );
    });
  });
}
