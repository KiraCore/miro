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

  group('Tests of RouterUtils.getNextRouteAfterLoading()', () {
    test('Should return [default route] if [initial path NOT exists]', () {
      // Act
      PageRouteInfo actualRoute = RouterUtils.getNextRouteAfterLoading(null);

      // Assert
      PageRouteInfo expectedRoute = dashboardPageRouteInfo;

      expect(actualRoute, expectedRoute);
    });

    test('Should return [default route] if [initial path is LoadingPage]', () {
      // Act
      PageRouteInfo actualRoute = RouterUtils.getNextRouteAfterLoading(loadingPageRouteInfo);

      // Assert
      PageRouteInfo expectedRoute = dashboardPageRouteInfo;

      expect(actualRoute, expectedRoute);
    });

    test('Should return [default route] if [initial path is NetworkListPage]', () {
      // Act
      PageRouteInfo actualRoute = RouterUtils.getNextRouteAfterLoading(networkListPageRouteInfo);

      // Assert
      PageRouteInfo expectedRoute = dashboardPageRouteInfo;

      expect(actualRoute, expectedRoute);
    });

    test('Should return [default route] if [initial path is equal default route]', () {
      // Act
      PageRouteInfo actualRoute = RouterUtils.getNextRouteAfterLoading(dashboardPageRouteInfo);

      // Assert
      PageRouteInfo expectedRoute = dashboardPageRouteInfo;

      expect(actualRoute, expectedRoute);
    });

    test('Should return [route from initial path] if [initial route is different than LoadingPage or NetworkListPage]', () {
      // Act
      PageRouteInfo actualRoute = RouterUtils.getNextRouteAfterLoading(accountsPageRouteInfo);

      // Assert
      PageRouteInfo expectedRouteName = accountsPageRouteInfo;

      expect(actualRoute, expectedRouteName);
    });
  });
}
