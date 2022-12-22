import 'package:flutter/material.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_title/balance_list_title_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_title/balance_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class BalanceListTitle extends StatelessWidget {
  const BalanceListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      largeScreen: BalanceListTitleDesktop(),
      mediumScreen: BalanceListTitleMobile(),
    );
  }
}
