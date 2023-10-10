import 'package:auto_route/auto_route.dart';
import 'package:miro/shared/router/guards/auth_guard.dart';
import 'package:miro/shared/router/guards/connection_guard.dart';
import 'package:miro/shared/router/guards/navigation_guard.dart';
import 'package:miro/shared/router/guards/pages/loading_page_guard.dart';
import 'package:miro/shared/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  final AuthGuard authGuard = AuthGuard();
  final ConnectionGuard connectionGuard = ConnectionGuard();
  final NavigationGuard navigationGuard = NavigationGuard();
  late final LoadingPageGuard loadingPageGuard = LoadingPageGuard(connectionGuard: connectionGuard);

  @override
  RouteType get defaultRouteType => const RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);

  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      AutoRoute(
        page: PagesWrapperRoute.page,
        path: '/',
        guards: <AutoRouteGuard>[connectionGuard],
        initial: true,
        children: <AutoRoute>[
          AutoRoute(
            page: LoadingWrapperRoute.page,
            path: 'network',
            initial: true,
            children: <AutoRoute>[
              AutoRoute(
                page: NetworkListRoute.page,
                path: 'list',
              ),
              AutoRoute(
                page: LoadingRoute.page,
                path: 'loading',
                guards: <AutoRouteGuard>[loadingPageGuard],
              ),
            ],
          ),
          AutoRoute(
            page: MenuWrapperRoute.page,
            path: 'app',
            children: <AutoRoute>[
              AutoRoute(
                page: DashboardRoute.page,
                path: 'dashboard',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: ValidatorsRoute.page,
                path: 'validators',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: MyAccountRoute.page,
                path: 'my-account',
                guards: <AutoRouteGuard>[authGuard, navigationGuard],
              ),
            ],
          ),
          AutoRoute(
            page: TransactionsWrapperRoute.page,
            path: 'transactions',
            guards: <AutoRouteGuard>[authGuard],
            children: <AutoRoute>[
              AutoRoute(
                page: TxSendTokensRoute.page,
                path: 'tokens/send',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: IRTxRegisterRecordRoute.page,
                path: 'identity-records/register',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: IRTxDeleteRecordRoute.page,
                path: 'identity-records/delete',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: IRTxRequestVerificationRoute.page,
                path: 'identity-records/verify',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
              AutoRoute(
                page: IRTxHandleVerificationRequestRoute.page,
                path: 'identity/handle-verification-request',
                guards: <AutoRouteGuard>[navigationGuard],
              ),
            ],
          ),
        ],
      ),
      RedirectRoute(path: '*', redirectTo: '/'),
    ];
  }
}
