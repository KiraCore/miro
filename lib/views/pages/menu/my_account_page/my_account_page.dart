import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_page.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/identity_registrar_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page_header.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_page.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_page.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegations_page.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_page.dart';
import 'package:miro/views/widgets/generic/sliver_tab_bar_view.dart';
import 'package:miro/views/widgets/kira/kira_tab_bar/kira_tab_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: 6, vsync: this);

  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, Wallet?>(
      bloc: authCubit,
      builder: (BuildContext context, Wallet? wallet) {
        if (authCubit.isSignedIn == false) {
          return const SizedBox();
        }
        return CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverPadding(
              padding: AppSizes.getPagePadding(context),
              sliver: MultiSliver(
                children: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyAccountPageHeader(wallet: wallet!),
                        const SizedBox(height: 20),
                        KiraTabBar(tabController: tabController, tabs: <Tab>[
                          Tab(text: S.of(context).balances),
                          Tab(text: S.of(context).tx),
                          Tab(text: S.of(context).ir),
                          Tab(text: S.of(context).irVerificationRequests),
                          Tab(text: S.of(context).staking),
                          Tab(text: S.of(context).unstaked),
                        ]),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  SliverTabBarView(
                    tabController: tabController,
                    children: <Widget>[
                      BalancePage(walletAddress: wallet.address, parentScrollController: scrollController),
                      TransactionsPage(walletAddress: wallet.address, parentScrollController: scrollController),
                      IdentityRegistrarPage(walletAddress: wallet.address),
                      VerificationRequestsPage(walletAddress: wallet.address, parentScrollController: scrollController),
                      StakingPage(walletAddress: wallet.address),
                      UndelegationsPage(walletAddress: wallet.address, parentScrollController: scrollController),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
