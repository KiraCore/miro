import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page/login_mnemonic_page.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/drawer_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  GlobalKey<ScaffoldState>? actualScaffoldKey;
  DrawerCubit drawerCubit = DrawerCubit();

  const Widget firstRoute = CreateWalletPage();
  const Widget secondRoute = LoginKeyfilePage();
  const Widget thirdRoute = LoginMnemonicPage();

  group('Tests of navigate() method', () {
    test('Should navigate to provided Widget and update route history when added Widget to route stack first time', () {
      drawerCubit.navigate(actualScaffoldKey, firstRoute);

      // Because the tested method doesn't work properly outside the test, we need to check method within one test
      TestUtils.printInfo('Should return DrawerNavigate state with current route and false canPop status');
      expect(
        drawerCubit.state,
        DrawerNavigate(currentRoute: firstRoute, canPop: false),
      );

      TestUtils.printInfo('Should return current route history');
      expect(
        drawerCubit.pagesHistory,
        <Widget>[firstRoute],
      );

      TestUtils.printInfo('Should return false if route history has only one item');
      expect(
        drawerCubit.canPop,
        false,
      );
    });

    test('Should navigate to provided Widget and update route history when added Widget to route stack next time', () {
      drawerCubit.navigate(actualScaffoldKey, secondRoute);
      TestUtils.printInfo('Should return DrawerNavigate state with current route and true canPop status');
      expect(
        drawerCubit.state,
        DrawerNavigate(currentRoute: secondRoute, canPop: true),
      );

      TestUtils.printInfo('Should return current route history');
      expect(
        drawerCubit.pagesHistory,
        <Widget>[firstRoute, secondRoute],
      );

      TestUtils.printInfo('Should return true if route history have more than one item');
      expect(
        drawerCubit.canPop,
        true,
      );
    });
  });

  group('Tests of replace() method', () {
    test('Should replace last history Widget with provided Widget and update route history', () {
      drawerCubit.replace(actualScaffoldKey, thirdRoute);
      TestUtils.printInfo('Should return DrawerNavigate state with current route and true canPop status');
      expect(
        drawerCubit.state,
        DrawerNavigate(currentRoute: thirdRoute, canPop: true),
      );

      TestUtils.printInfo('Should return current route history');
      expect(
        drawerCubit.pagesHistory,
        <Widget>[firstRoute, thirdRoute],
      );

      TestUtils.printInfo('Should return true if route history have more than one item');
      expect(
        drawerCubit.canPop,
        true,
      );
    });
  });

  group('Tests of pop() method', () {
    test('Should remove last history Widget and update route history', () {
      drawerCubit.pop(actualScaffoldKey);
      TestUtils.printInfo('Should return DrawerNavigate state with current route and false canPop status');
      expect(
        drawerCubit.state,
        DrawerNavigate(currentRoute: firstRoute, canPop: false),
      );

      TestUtils.printInfo('Should return current route history');
      expect(
        drawerCubit.pagesHistory,
        <Widget>[firstRoute],
      );

      TestUtils.printInfo('Should return false if route history has only one item');
      expect(
        drawerCubit.canPop,
        false,
      );
    });
  });

  group('Tests of closeDrawer() method', () {
    test('Should clear route history stack after drawer close', () {
      drawerCubit.closeDrawer(actualScaffoldKey);
      TestUtils.printInfo('Should return DrawerNoRouteState()');
      expect(
        drawerCubit.state,
        DrawerNoRouteState(),
      );

      TestUtils.printInfo('Should return empty route history');
      expect(
        drawerCubit.pagesHistory.length,
        0,
      );

      TestUtils.printInfo('Should return false if route history is empty');
      expect(
        drawerCubit.canPop,
        false,
      );
    });
  });
}
