import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/guards/auth_guard.dart';
import 'package:miro/shared/guards/connection_guard.dart';
import 'package:miro/shared/guards/navigation_guard.dart';
import 'package:miro/shared/guards/url_parameters_guard.dart';
import 'package:miro/views/pages/loading/connections_page/connections_page.dart';
import 'package:miro/views/pages/loading/loading_page/loading_page.dart';
import 'package:miro/views/pages/loading/loading_wrapper.dart';
import 'package:miro/views/pages/menu/accounts_page/accounts_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/pages_wrapper.dart';

// ignore_for_file: always_specify_types
@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  CustomRoute<void>(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    page: LoadingWrapper,
    name: 'LoadingWrapperRoute',
    path: '/connection',
    children: [
      CustomRoute<void>(
        transitionsBuilder: TransitionsBuilders.fadeIn,
        page: LoadingPage,
        name: 'LoadingRoute',
        path: 'loading',
      ),
      CustomRoute<void>(
        transitionsBuilder: TransitionsBuilders.fadeIn,
        page: ConnectionsPage,
        name: 'ConnectionsRoute',
        path: 'select',
      ),
    ],
  ),
  CustomRoute<void>(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 1000,
    page: PagesWrapper,
    name: 'PagesRoute',
    path: '/',
    initial: true,
    guards: [ConnectionGuard],
    children: [
      CustomRoute<void>(
        page: AccountsPage,
        name: 'AccountsRoute',
        path: 'accounts',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: DashboardPage,
        name: 'DashboardRoute',
        path: 'dashboard',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: MyAccountPage,
        name: 'MyAccountRoute',
        path: 'my-account',
        guards: [AuthGuard, UrlParametersGuard, NavigationGuard],
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
      RedirectRoute(path: '', redirectTo: 'dashboard')
    ],
  ),
  RedirectRoute(path: '', redirectTo: '/')
])
class $AppRouter {}
