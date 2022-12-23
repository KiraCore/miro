import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/shared/utils/router_utils.dart';

// To run tests use:
// fvm flutter test "test/unit/shared/utils/router_utils_test.dart" --platform chrome --null-assertions
void main() {
  PageRouteInfo dashboardPageRouteInfo = const PagesWrapperRoute(
    children: <PageRouteInfo>[
      MenuWrapperRoute(children: <PageRouteInfo>[DashboardRoute()]),
    ],
  );

  PageRouteInfo accountsPageRouteInfo = const PagesWrapperRoute(
    children: <PageRouteInfo>[
      MenuWrapperRoute(children: <PageRouteInfo>[ValidatorsRoute()]),
    ],
  );

  PageRouteInfo loadingPageRouteInfo = PagesWrapperRoute(
    children: <PageRouteInfo>[
      LoadingWrapperRoute(children: <PageRouteInfo>[LoadingRoute()]),
    ],
  );

  PageRouteInfo networkListPageRouteInfo = PagesWrapperRoute(
    children: <PageRouteInfo>[
      LoadingWrapperRoute(children: <PageRouteInfo>[NetworkListRoute()]),
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
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(loadingPageRouteInfo).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return default route if initial path is network list page', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(networkListPageRouteInfo).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return default route if initial path is equal default route', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(dashboardPageRouteInfo).fullPath;

      // Assert
      expect(
        actualRoutePath,
        expectedDefaultRoutePath,
      );
    });

    test('Should return route from initial path if initial route is other than connecting or loading page', () {
      // Act
      String actualRoutePath = RouterUtils.getNextRouteAfterLoading(accountsPageRouteInfo).fullPath;

      // Assert
      String expectedRoutePath = '/app/validators';

      expect(
        actualRoutePath,
        expectedRoutePath,
      );
    });
  });
}
