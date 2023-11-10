import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/guards/auth_guard.dart';
import 'package:miro/shared/router/guards/connection_guard.dart';
import 'package:miro/shared/router/guards/pages/loading_page_guard.dart';
import 'package:miro/shared/router/guards/pages/network_list_page_guard.dart';
import 'package:miro/shared/router/observers/menu_navigation_observer.dart';
import 'package:miro/shared/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  static MenuNavigationObserver menuNavigationObserver = MenuNavigationObserver();

  final AuthGuard authGuard = AuthGuard();
  final ConnectionGuard connectionGuard = ConnectionGuard();

  @override
  RouteType get defaultRouteType => const RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);

  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      AutoRoute(
        page: LoadingWrapperRoute.page,
        path: '/network',
        initial: true,
        children: <AutoRoute>[
          AutoRoute(
            initial: true,
            page: LoadingRoute.page,
            path: 'loading',
            guards: <AutoRouteGuard>[LoadingPageGuard()],
          ),
          AutoRoute(
            page: NetworkListRoute.page,
            path: 'list',
            guards: <AutoRouteGuard>[NetworkListPageGuard()],
          ),
        ],
      ),
      AutoRoute(
        page: MenuWrapperRoute.page,
        path: '/app',
        guards: <AutoRouteGuard>[connectionGuard],
        children: <AutoRoute>[
          AutoRoute(
            page: DashboardRoute.page,
            path: 'dashboard',
          ),
          AutoRoute(
            page: ValidatorsRoute.page,
            path: 'validators',
          ),
          AutoRoute(
            page: BlocksRoute.page,
            path: 'blocks',
          ),
          AutoRoute(
            page: MyAccountRoute.page,
            path: 'my-account',
            guards: <AutoRouteGuard>[authGuard],
          ),
        ],
      ),
      AutoRoute(
        page: TransactionsWrapperRoute.page,
        path: '/transactions',
        guards: <AutoRouteGuard>[connectionGuard, authGuard],
        children: <AutoRoute>[
          AutoRoute(
            page: TxSendTokensRoute.page,
            path: 'tokens/send',
          ),
          AutoRoute(
            page: IRTxRegisterRecordRoute.page,
            path: 'identity-records/register',
          ),
          AutoRoute(
            page: IRTxDeleteRecordRoute.page,
            path: 'identity-records/delete',
          ),
          AutoRoute(
            page: IRTxRequestVerificationRoute.page,
            path: 'identity-records/verify',
          ),
          AutoRoute(
            page: IRTxHandleVerificationRequestRoute.page,
            path: 'identity/handle-verification-request',
          ),
          AutoRoute(
            page: StakingTxDelegateRoute.page,
            path: 'staking/stake-tokens',
          ),
          AutoRoute(
            page: StakingTxUndelegateRoute.page,
            path: 'staking/unstake-tokens',
          ),
          AutoRoute(
            page: StakingTxClaimRewardsRoute.page,
            path: 'staking/claim-rewards',
          ),
          AutoRoute(
            page: StakingTxClaimUndelegationRoute.page,
            path: 'staking/claim-unstaked',
          ),
        ],
      ),
      RedirectRoute(path: '*', redirectTo: '/network'),
    ];
  }
}