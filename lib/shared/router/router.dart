import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/guards/auth_guard.dart';
import 'package:miro/shared/guards/navigation_guard.dart';
import 'package:miro/shared/guards/url_parameters_guard.dart';
import 'package:miro/views/pages/menu/accounts_page/accounts_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/pages_wrapper.dart';
import 'package:miro/views/pages/transactions/send/msg_send_create_page.dart';
import 'package:miro/views/pages/transactions/transactions_wrapper.dart';

@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute<void>(
    page: PagesWrapper,
    name: 'PagesRoute',
    path: '/',
    initial: true,
    guards: <Type>[UrlParametersGuard],
    children: <AutoRoute>[
      CustomRoute<void>(
        page: AccountsPage,
        name: 'AccountsRoute',
        path: 'accounts',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: <Type>[UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: DashboardPage,
        name: 'DashboardRoute',
        path: 'dashboard',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: <Type>[UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: <Type>[UrlParametersGuard, NavigationGuard],
      ),
      CustomRoute<void>(
        page: MyAccountPage,
        name: 'MyAccountRoute',
        path: 'my-account',
        guards: <Type>[AuthGuard, UrlParametersGuard, NavigationGuard],
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
      RedirectRoute(path: '', redirectTo: 'dashboard')
    ],
  ),
  CustomRoute<void>(
    page: TransactionsWrapper,
    name: 'TransactionsWrapperRoute',
    path: '/transactions',
    guards: <Type>[AuthGuard, UrlParametersGuard],
    transitionsBuilder: TransitionsBuilders.fadeIn,
    children: <AutoRoute>[
      CustomRoute<void>(
        page: MsgSendCreatePage,
        name: 'MsgSendCreateRoute',
        path: 'tokens/send',
        guards: <Type>[AuthGuard, UrlParametersGuard],
        transitionsBuilder: TransitionsBuilders.fadeIn,
      ),
    ],
  ),
  RedirectRoute(path: '', redirectTo: '/')
])
class $AppRouter {}
