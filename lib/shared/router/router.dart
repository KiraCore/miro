import 'package:auto_route/annotations.dart';
import 'package:miro/views/pages/menu/accounts_page/accounts_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/pages_wrapper.dart';

// ignore_for_file: always_specify_types
@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute<void>(
    page: PagesWrapper,
    name: 'PagesRoute',
    path: '/',
    initial: true,
    children: [
      AutoRoute<void>(
        page: AccountsPage,
        name: 'AccountsRoute',
        path: 'accounts',
      ),
      AutoRoute<void>(
        page: DashboardPage,
        name: 'DashboardRoute',
        path: 'dashboard',
      ),
      AutoRoute<void>(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
      ),
      RedirectRoute(path: '', redirectTo: 'dashboard')
    ],
  ),
  RedirectRoute(path: '', redirectTo: '/')
])
class $AppRouter {}
