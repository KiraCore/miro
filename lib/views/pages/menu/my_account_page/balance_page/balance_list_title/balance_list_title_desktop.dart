import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_sort_dropdown.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/small_balances_checkbox.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class BalanceListTitleDesktop extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const BalanceListTitleDesktop({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(height: 15),
            BalanceSortDropdown(),
          ],
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SmallBalanceCheckbox(),
                  const SizedBox(width: 32),
                  Expanded(
                    child: ListSearchWidget<BalanceModel>(
                      textEditingController: searchBarTextEditingController,
                      hint: S.of(context).balancesSearch,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
