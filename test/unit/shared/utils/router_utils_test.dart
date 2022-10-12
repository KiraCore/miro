import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/router_utils.dart';

// To run tests use:
// fvm flutter test "test/unit/shared/utils/router_utils_test.dart" --platform chrome --null-assertions
void main() {
  RouteMatch<dynamic> dashboardRouteMatch = RouteMatch<dynamic>(
    name: 'PagesWrapperRoute',
    segments: const <String>['/'],
    path: '/',
    stringMatch: '/',
    key: UniqueKey(),
    children: <RouteMatch<dynamic>>[
      RouteMatch<dynamic>(
        name: 'MenuRoute',
        segments: const <String>['app'],
        path: 'app',
        stringMatch: 'app',
        key: UniqueKey(),
        children: <RouteMatch<dynamic>>[
          RouteMatch<dynamic>(
            name: 'DashboardRoute',
            segments: const <String>['dashboard'],
            path: 'dashboard',
            stringMatch: 'dashboard',
            key: UniqueKey(),
          ),
        ],
      ),
    ],
  );

  RouteMatch<dynamic> accountsRouteMatch = RouteMatch<dynamic>(
    name: 'PagesWrapperRoute',
    segments: const <String>['/'],
    path: '/',
    stringMatch: '/',
    key: UniqueKey(),
    children: <RouteMatch<dynamic>>[
      RouteMatch<dynamic>(
        name: 'MenuRoute',
        segments: const <String>['app'],
        path: 'app',
        stringMatch: 'app',
        key: UniqueKey(),
        children: <RouteMatch<dynamic>>[
          RouteMatch<dynamic>(
            name: 'AccountsRoute',
            segments: const <String>['accounts'],
            path: 'accounts',
            stringMatch: 'accounts',
            key: UniqueKey(),
          ),
        ],
      ),
    ],
  );

  RouteMatch<dynamic> loadingPageRouteMatch = RouteMatch<dynamic>(
    name: 'PagesWrapperRoute',
    segments: const <String>['/'],
    path: '/',
    stringMatch: '/',
    key: UniqueKey(),
    children: <RouteMatch<dynamic>>[
      RouteMatch<dynamic>(
        name: 'LoadingWrapperRoute',
        segments: const <String>['connection'],
        path: 'connection',
        stringMatch: 'connection',
        key: UniqueKey(),
        children: <RouteMatch<dynamic>>[
          RouteMatch<dynamic>(
            name: 'LoadingRoute',
            segments: const <String>['loading'],
            path: 'loading',
            stringMatch: 'loading',
            key: UniqueKey(),
          ),
        ],
      ),
    ],
  );

  RouteMatch<dynamic> networkListPagePageRouteMatch = RouteMatch<dynamic>(
    name: 'PagesWrapperRoute',
    segments: const <String>['/'],
    path: '/',
    stringMatch: '/',
    key: UniqueKey(),
    children: <RouteMatch<dynamic>>[
      RouteMatch<dynamic>(
        name: 'LoadingWrapperRoute',
        segments: const <String>['connection'],
        path: 'connection',
        stringMatch: 'connection',
        key: UniqueKey(),
        children: <RouteMatch<dynamic>>[
          RouteMatch<dynamic>(
            name: 'NetworkListRoute',
            segments: const <String>['select'],
            path: 'select',
            stringMatch: 'select',
            key: UniqueKey(),
          ),
        ],
      ),
    ],
  );

  const String expectedDefaultRoutePath = '/app/dashboard';

  group('Tests of getNextRouteAfterLoading()', () {
    test('Should return default route if initial path doesn`t exists', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(null).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return default route if initial path is loading page', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(loadingPageRouteMatch).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return default route if initial path is network list page', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(networkListPagePageRouteMatch).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return default route if initial path is equal default route', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(dashboardRouteMatch).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return route from initial path if initial route is other than connecting or loading page', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(accountsRouteMatch).fullPath;

      // Assert
      String expectedRoutePath = '/app/accounts';

      expect(
        actualRoutePath,
        expectedRoutePath,
      );
    });
  });
}
