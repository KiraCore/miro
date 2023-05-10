import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/layout/drawer/drawer_cubit.dart';
import 'package:miro/blocs/layout/drawer/states/drawer_hidden_state.dart';
import 'package:miro/blocs/layout/drawer/states/drawer_visible_state.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page/login_mnemonic_page.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/layout/drawer_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  GlobalKey<ScaffoldState> actualScaffoldKey = GlobalKey<ScaffoldState>();
  DrawerCubit actualDrawerCubit = DrawerCubit();

  const Widget firstRoute = CreateWalletPage();
  const Widget secondRoute = LoginKeyfilePage();
  const Widget thirdRoute = LoginMnemonicPage();

  group('Tests of DrawerCubit process', () {
    test('Should return ADrawerState consistent with current route', () {
      // Act
      actualDrawerCubit.navigate(actualScaffoldKey, firstRoute);

      // Assert
      TestUtils.printInfo('Should navigate to provided Widget and update route history when added Widget to route stack first time');
      expect(actualDrawerCubit.state, DrawerVisibleState(currentRoute: firstRoute, canPop: false));
      expect(actualDrawerCubit.routeHistory, <Widget>[firstRoute]);
      expect(actualDrawerCubit.canPop, false);

      // ************************************************************************

      // Act
      actualDrawerCubit.navigate(actualScaffoldKey, secondRoute);

      TestUtils.printInfo('Should navigate to provided Widget and update route history when added Widget to route stack second time');
      expect(actualDrawerCubit.state, DrawerVisibleState(currentRoute: secondRoute, canPop: true));
      expect(actualDrawerCubit.routeHistory, <Widget>[firstRoute, secondRoute]);
      expect(actualDrawerCubit.canPop, true);

      // ************************************************************************

      // Act
      actualDrawerCubit.replace(actualScaffoldKey, thirdRoute);

      // Assert
      TestUtils.printInfo('Should replace last history Widget with provided Widget and update route history');
      expect(actualDrawerCubit.state, DrawerVisibleState(currentRoute: thirdRoute, canPop: true));
      expect(actualDrawerCubit.routeHistory, <Widget>[firstRoute, thirdRoute]);
      expect(actualDrawerCubit.canPop, true);

      // ************************************************************************

      // Act
      actualDrawerCubit.pop(actualScaffoldKey);

      // Assert
      TestUtils.printInfo('Should remove last history Widget and update route history');
      expect(actualDrawerCubit.state, DrawerVisibleState(currentRoute: firstRoute, canPop: false));
      expect(actualDrawerCubit.routeHistory, <Widget>[firstRoute]);
      expect(actualDrawerCubit.canPop, false);

      // ************************************************************************

      // Act
      actualDrawerCubit.closeDrawer(actualScaffoldKey);

      // Assert
      TestUtils.printInfo('Should clear route history stack after drawer close');
      expect(actualDrawerCubit.state, DrawerHiddenState());
      expect(actualDrawerCubit.routeHistory.length, 0);
      expect(actualDrawerCubit.canPop, false);
    });
  });
}
