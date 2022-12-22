import 'package:flutter/material.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_sort_dropdown.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/small_balances_checkbox.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class BalanceListTitleMobile extends StatelessWidget {
  const BalanceListTitleMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const LastBlockTimeWidget(),
        const SizedBox(height: 15),
        const ListSearchWidget<BalanceModel>(
          width: double.infinity,
          hint: 'Search balances',
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SmallBalanceCheckbox(),
            BalanceSortDropdown(width: ResponsiveWidget.isSmallScreen(context) ? 62 : 100),
          ],
        ),
      ],
    );
  }
}
