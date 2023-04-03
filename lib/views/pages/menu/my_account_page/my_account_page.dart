import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_page_header.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_page.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';
import 'package:miro/views/widgets/kira/kira_tab_bar/kira_tab_bar.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> with SingleTickerProviderStateMixin {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final List<String> tabs = <String>['Balance', 'Transactions'];

  late final ValueNotifier<String> selectedPageNotifier = ValueNotifier<String>(tabs[0]);
  late final TabController tabController = TabController(length: tabs.length, vsync: this);

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    tabController.addListener(_handleTabChange);
  }

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
                        KiraTabBar(
                          tabController: tabController,
                          tabs: tabs.map((String tabTitle) => Tab(text: tabTitle)).toList(),
                        ),
                        const SizedBox(height: 15),
                        const LastBlockTimeWidget(),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedPageNotifier,
                    builder: (_, String pageName, __) {
                      return _selectCurrentPage(pageName: pageName, wallet: wallet);
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
    String selectedTab = tabs[selectedIndex];
    selectedPageNotifier.value = selectedTab;
  }

  Widget _selectCurrentPage({required String pageName, required Wallet wallet}) {
    switch (pageName) {
      case 'Balance':
        return BalancePage(
          address: wallet.address.bech32Address,
          parentScrollController: scrollController,
        );
      case 'Transactions':
        return const TransactionsPage();
      default:
        return const SizedBox();
    }
  }
}
