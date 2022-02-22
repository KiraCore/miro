import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/footer/footer.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_page.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_page.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';
import 'package:miro/views/widgets/generic/responsive/sized_box_expanded.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

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
    wallet = globalLocator<WalletProvider>().currentWallet!;
    pages = <Widget, Widget>{
      BalancePage(parentScrollController: scrollController): _buildNavigationTab('Balance'),
      const TransactionsPage(): _buildNavigationTab('Transactions')
    };
    currentPage = pages.keys.first;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyAccountPage oldWidget) {
    wallet = globalLocator<WalletProvider>().currentWallet!;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: <Widget>[
        Padding(
          padding: AppSizes.defaultPageMargin,
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
        Container(
          constraints: const BoxConstraints(
            minHeight: 62,
          ),
          child: Row(
            children: <Widget>[
              KiraIdentityAvatar(
                address: wallet.address.bech32Address,
                size: 62,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      wallet.address.bech32Shortcut,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: DesignColors.white_100,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 430,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        title: Text(
                          wallet.address.bech32Address,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: DesignColors.blue1_100,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: _copyPublicAddress,
                          icon: const Icon(
                            AppIcons.copy,
                            color: DesignColors.gray2_100,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  void _copyPublicAddress() {
    Clipboard.setData(ClipboardData(text: wallet.address.bech32Address));
    KiraToast.show('Public address copied');
  }
}
