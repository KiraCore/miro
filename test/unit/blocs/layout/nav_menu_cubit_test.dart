import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_cubit.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_state.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/layout/nav_menu_cubit_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of [NavMenuCubit] process', () {
    test('Should return valid state associated to the following actions', () {
      // Arrange
      NavMenuCubit actualNavMenuCubit = NavMenuCubit();

      // Assert
      NavMenuState expectedNavMenuState = const NavMenuState.empty();

      TestUtils.printInfo('Should return [NavMenuState.empty()] as initial state');
      expect(actualNavMenuCubit.state, expectedNavMenuState);

      // ************************************************************************************************

      // Act
      actualNavMenuCubit.updateRouteName('ValidatorsRoute');

      // Assert
      expectedNavMenuState = const NavMenuState(selectedRouteName: 'ValidatorsRoute');

      TestUtils.printInfo('Should return [NavMenuState] with "ValidatorsRoute" name ');
      expect(actualNavMenuCubit.state, expectedNavMenuState);

      // ************************************************************************************************

      // Act
      actualNavMenuCubit.updateRouteName('DashboardRoute');

      // Assert
      expectedNavMenuState = const NavMenuState(selectedRouteName: 'DashboardRoute');

      TestUtils.printInfo('Should return [NavMenuState] with "DashboardRoute" name ');
      expect(actualNavMenuCubit.state, expectedNavMenuState);
    });
  });
}
