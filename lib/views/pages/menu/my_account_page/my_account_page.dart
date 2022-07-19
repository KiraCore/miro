import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/footer/footer.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_page.dart';
import 'package:miro/views/pages/menu/my_account_page/my_account_tile.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';
import 'package:miro/views/widgets/generic/responsive/sized_box_expanded.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> {
  late Map<Widget, Widget> pages;

  ScrollController scrollController = ScrollController();
  late Wallet wallet;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    wallet = globalLocator<WalletProvider>().currentWallet!;
    pages = <Widget, Widget>{
      BalancePage(parentScrollController: scrollController): _buildNavigationTab('Balance'),
      const TransactionsPage(): _buildNavigationTab('Transactions')
    };
    currentPage = pages.keys.first;
  }

  @override
  void didUpdateWidget(covariant MyAccountPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    wallet = globalLocator<WalletProvider>().currentWallet!;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: <Widget>[
        Padding(
          padding: ResponsiveWidget.isLargeScreen(context)
              ? AppSizes.defaultDesktopPageMargin
              : AppSizes.defaultMobilePageMargin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeaderSection(),
              const SizedBox(height: 36),
              CupertinoSlidingSegmentedControl<Widget>(
                groupValue: currentPage,
                children: pages,
                onValueChanged: _onPageChanged,
                backgroundColor: DesignColors.blue1_10,
                thumbColor: DesignColors.blue1_100,
                padding: const EdgeInsets.all(8),
              ),
              const SizedBox(height: 20),
              currentPage,
              const SizedBox(height: 36),
              const Footer(),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildNavigationTab(String title) {
    return SizedBox(
      height: 30,
      width: 138,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: DesignColors.white_100),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return ColumnRowSwapper(
      expandOnRow: true,
      children: <Widget>[
        MyAccountTile(wallet: wallet),
        const ColumnRowSpacer(size: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBoxExpanded(
              width: 105,
              expandOn: const <ScreenSize>[
                ScreenSize.mobile,
                ScreenSize.tablet,
              ],
              child: KiraElevatedButton(
                onPressed: () {},
                title: 'Pay',
              ),
            ),
            const SizedBox(width: 12),
            SizedBoxExpanded(
              width: 105,
              expandOn: const <ScreenSize>[
                ScreenSize.mobile,
                ScreenSize.tablet,
              ],
              child: KiraElevatedButton(
                onPressed: () {},
                title: 'Request',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onPageChanged(Widget? page) {
    setState(() {
      currentPage = page!;
    });
  }
}
