import 'package:auto_route/annotations.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/connection_drawer_page.dart';
import 'package:miro/views/pages/drawer/create_wallet_page/create_wallet_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_keyfile_page.dart';
import 'package:miro/views/pages/drawer/login_page/login_mnemonic_page.dart';
import 'package:miro/views/pages/menu/accounts_page/accounts_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/menu/welcome_page/welcome_page.dart';
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
        page: CreateWalletPage,
        name: 'CreateWalletRoute',
        path: 'create-wallet',
      ),
      AutoRoute<void>(
        page: ConnectionDrawerPage,
        name: 'ConnectionRoute',
        path: 'connection',
      ),
      AutoRoute<void>(
        page: LoginKeyfilePage,
        name: 'LoginKeyfileRoute',
        path: 'login-keyfile',
      ),
      AutoRoute<void>(
        page: LoginMnemonicPage,
        name: 'LoginMnemonicRoute',
        path: 'login-mnemonic',
      ),
      AutoRoute<void>(
        page: ValidatorsPage,
        name: 'ValidatorsRoute',
        path: 'validators',
      ),
      AutoRoute<void>(
        page: WelcomePage,
        name: 'WelcomeRoute',
        path: 'welcome',
      ),
      RedirectRoute(path: '', redirectTo: 'dashboard')
    ],
  ),
  RedirectRoute(path: '', redirectTo: '/')
])
class $AppRouter {}
