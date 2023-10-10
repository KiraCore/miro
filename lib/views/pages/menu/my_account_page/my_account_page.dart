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
import 'package:miro/views/pages/menu/my_account_page/my_account_tab_mode.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_page.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_requests_page.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';
import 'package:miro/views/widgets/kira/kira_tab_bar/kira_tab_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> with SingleTickerProviderStateMixin {
  late final TabController tabController = TabController(length: MyAccountTabMode.values.length, vsync: this);

  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<MyAccountTabMode> selectedPageNotifier = ValueNotifier<MyAccountTabMode>(MyAccountTabMode.values.first);

  @override
  void initState() {
    super.initState();
    tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    tabController.dispose();
    scrollController.dispose();
    selectedPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<MyAccountTabMode, String> tabNames = <MyAccountTabMode, String>{
      MyAccountTabMode.balances: S.of(context).balances,
      MyAccountTabMode.transactions: S.of(context).tx,
      MyAccountTabMode.identityRegistrar: S.of(context).ir,
      MyAccountTabMode.verificationRequests: S.of(context).irVerificationRequests,
    };

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
                        KiraTabBar(
                          tabController: tabController,
                          tabs: MyAccountTabMode.values.map((MyAccountTabMode myAccountTabMode) => Tab(text: tabNames[myAccountTabMode])).toList(),
                        ),
                        const SizedBox(height: 15),
                        const LastBlockTimeWidget(),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<MyAccountTabMode>(
                    valueListenable: selectedPageNotifier,
                    builder: (_, MyAccountTabMode myAccountTabMode, __) {
                      return _selectCurrentPage(myAccountTabMode: myAccountTabMode, wallet: wallet);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleTabChange() {
    int selectedIndex = tabController.index;
    MyAccountTabMode myAccountTabMode = MyAccountTabMode.values[selectedIndex];
    selectedPageNotifier.value = myAccountTabMode;
  }

  Widget _selectCurrentPage({required MyAccountTabMode myAccountTabMode, required Wallet wallet}) {
    switch (myAccountTabMode) {
      case MyAccountTabMode.balances:
        return BalancePage(
          address: wallet.address.bech32Address,
          parentScrollController: scrollController,
        );
      case MyAccountTabMode.transactions:
        return TransactionsPage(
          address: wallet.address.bech32Address,
          parentScrollController: scrollController,
        );
      case MyAccountTabMode.identityRegistrar:
        return IdentityRegistrarPage(walletAddress: wallet.address);
      case MyAccountTabMode.verificationRequests:
        return VerificationRequestsPage(
          walletAddress: wallet.address,
          parentScrollController: scrollController,
        );
      default:
        return const SizedBox();
    }
  }
}
