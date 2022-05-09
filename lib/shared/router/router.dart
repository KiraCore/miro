import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/guards/auth_guard.dart';
import 'package:miro/shared/guards/empty_params_guard.dart';
import 'package:miro/shared/guards/navigation_guard.dart';
import 'package:miro/shared/guards/url_parameters_guard.dart';
import 'package:miro/views/pages/dialog/dialog_wrapper.dart';
import 'package:miro/views/pages/dialog/transaction_create_page/transaction_create_page.dart';
import 'package:miro/views/pages/dialog/transaction_request_page/transaction_request_page.dart';
import 'package:miro/views/pages/dialog/transaction_request_page/transaction_request_result_page.dart';
import 'package:miro/views/pages/dialog/transaction_sign/transaction_broadcast_page.dart';
import 'package:miro/views/pages/dialog/transaction_sign/transaction_confirm_page.dart';
import 'package:miro/views/pages/dialog/transaction_sign/transaction_scan_page.dart';
import 'package:miro/views/pages/dialog/transaction_sign/transaction_sign_with_saifu_page.dart';
import 'package:miro/views/pages/menu/accounts_page/accounts_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/pages_wrapper.dart';

// ignore_for_file: always_specify_types
@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute<void>(
    page: PagesWrapper,
    name: 'PagesRoute',
    path: '/',
    initial: true,
    guards: [UrlParametersGuard],
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
      RedirectRoute(path: '*', redirectTo: 'dashboard')
    ],
  ),
  CustomRoute<void>(
    page: DialogWrapper,
    name: 'DialogWrapperRoute',
    path: '/d',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 500,
    children: [
      CustomRoute<void>(
        page: TransactionRequestPage,
        name: 'TransactionRequestRoute',
        path: 'transaction/request',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionRequestResultPage,
        name: 'TransactionRequestResultRoute',
        path: 'transaction/request/result',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionCreatePage,
        name: 'TransactionCreateRoute',
        path: 'transaction/create',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionSignWithSaifuPage,
        name: 'TransactionSignWithSaifuRoute',
        path: 'transaction/saifu/sign',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionScanPage,
        name: 'TransactionScanRoute',
        path: 'transaction/saifu/scan',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionConfirmPage,
        name: 'TransactionConfirmRoute',
        path: 'transaction/confirm',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      CustomRoute<void>(
        page: TransactionBroadcastPage,
        name: 'TransactionBroadcastRoute',
        path: 'transaction/broadcast',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        guards: [EmptyParamsGuard],
        durationInMilliseconds: 500,
      ),
      RedirectRoute(path: '*', redirectTo: '/'),
    ],
  ),
  RedirectRoute(path: '*', redirectTo: '/')
])
class $AppRouter {}
