import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/guards/auth_guard.dart';
import 'package:miro/shared/router/guards/connection_guard.dart';
import 'package:miro/shared/router/guards/navigation_guard.dart';
import 'package:miro/shared/router/guards/pages/loading_page_guard.dart';
import 'package:miro/views/pages/loading/loading_page/loading_page.dart';
import 'package:miro/views/pages/loading/loading_wrapper.dart';
import 'package:miro/views/pages/loading/network_list_page/network_list_page.dart';
import 'package:miro/views/pages/menu/dashboard_page/dashboard_page.dart';
import 'package:miro/views/pages/menu/menu_wrapper.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page.dart';
import 'package:miro/views/pages/menu/validators_page/validators_page.dart';
import 'package:miro/views/pages/pages_wrapper.dart';
import 'package:miro/views/pages/transactions/transactions_wrapper.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_delete_record_page/ir_tx_delete_record_page.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_handle_verification_request_page/ir_tx_handle_verification_request_page.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_register_record_page/ir_tx_register_record_page.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_request_verification_page/ir_tx_request_verification_page.dart';
import 'package:miro/views/pages/transactions/tx_send/staking_tx_delegate_page/staking_tx_delegate_page.dart';
import 'package:miro/views/pages/transactions/tx_send/tx_send_tokens/tx_send_tokens_page.dart';

@CustomAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  CustomRoute<void>(
    initial: true,
    page: PagesWrapper,
    name: 'PagesWrapperRoute',
    path: '/',
    guards: <Type>[ConnectionGuard],
    children: <AutoRoute>[
      CustomRoute<void>(
        initial: true,
        page: LoadingWrapper,
        name: 'LoadingWrapperRoute',
        path: 'network',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        children: <AutoRoute>[
          CustomRoute<void>(
            initial: true,
            page: NetworkListPage,
            name: 'NetworkListRoute',
            path: 'list',
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: LoadingPage,
            name: 'LoadingRoute',
            path: 'loading',
            guards: <Type>[LoadingPageGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
        ],
      ),
      CustomRoute<void>(
        page: MenuWrapper,
        name: 'MenuWrapperRoute',
        path: 'app',
        transitionsBuilder: TransitionsBuilders.fadeIn,
        durationInMilliseconds: 1000,
        children: <AutoRoute>[
          CustomRoute<void>(
            page: DashboardPage,
            name: 'DashboardRoute',
            path: 'dashboard',
            guards: <Type>[NavigationGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: ValidatorsPage,
            name: 'ValidatorsRoute',
            path: 'validators',
            guards: <Type>[NavigationGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: MyAccountPage,
            name: 'MyAccountRoute',
            path: 'my-account',
            guards: <Type>[AuthGuard, NavigationGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
        ],
      ),
      CustomRoute<void>(
        page: TransactionsWrapper,
        name: 'TransactionsWrapperRoute',
        path: 'transactions',
        guards: <Type>[AuthGuard],
        transitionsBuilder: TransitionsBuilders.fadeIn,
        children: <AutoRoute>[
          CustomRoute<void>(
            page: TxSendTokensPage,
            name: 'TxSendTokensRoute',
            path: 'tokens/send',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: IRTxRegisterRecordPage,
            name: 'IRTxRegisterRecordRoute',
            path: 'identity/register',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: IRTxDeleteRecordPage,
            name: 'IRTxDeleteRecordRoute',
            path: 'identity/delete',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: IRTxRequestVerificationPage,
            name: 'IRTxRequestVerificationRoute',
            path: 'identity/verify',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: IRTxHandleVerificationRequestPage,
            name: 'IRTxHandleVerificationRequestRoute',
            path: 'identity/handle-verification-request',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
          CustomRoute<void>(
            page: StakingTxDelegatePage,
            name: 'TxDelegateRoute',
            path: 'staking/delegate',
            guards: <Type>[AuthGuard],
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
        ],
      ),
    ],
  ),
  RedirectRoute(path: '*', redirectTo: '/'),
])
class $AppRouter {}
