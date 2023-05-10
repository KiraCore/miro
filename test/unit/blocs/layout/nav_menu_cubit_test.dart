import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_cubit.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_state.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/layout/nav_menu_cubit_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of MenuProvider initial state', () {
    test('Should return default path', () {
      // Arrange
      NavMenuCubit actualNavMenuCubit = NavMenuCubit();

      // Assert
      NavMenuState expectedNavMenuState = const NavMenuState.empty();

      TestUtils.printInfo('Should return NavMenuState.empty() as initial state');
      expect(actualNavMenuCubit.state, expectedNavMenuState);

      // ************************************************************************************************

      // Act
      actualNavMenuCubit.updatePath('accounts');

      // Assert
      expectedNavMenuState = const NavMenuState(selectedPath: 'accounts');

      TestUtils.printInfo('Should return NavMenuState with "accounts" path ');
      expect(actualNavMenuCubit.state, expectedNavMenuState);

      // ************************************************************************************************

      // Act
      actualNavMenuCubit.updatePath('dashboard');

      // Assert
      expectedNavMenuState = const NavMenuState(selectedPath: 'dashboard');

      TestUtils.printInfo('Should return NavMenuState with "dashboard" path ');
      expect(actualNavMenuCubit.state, expectedNavMenuState);
    });
  });
}
