import 'package:flutter/material.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_sort_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class BalanceSortDropdown extends StatelessWidget {
  final double width;
  
  const BalanceSortDropdown({
    this.width = 100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SortDropdown<BalanceModel>(
      width: width,
      sortOptionModels: <SortOptionModel<BalanceModel>>[
        SortOptionModel<BalanceModel>(
          title: 'Name',
          sortOption: BalancesSortOptions.sortByDenom,
        ),
        SortOptionModel<BalanceModel>(
          title: 'Amount',
          sortOption: BalancesSortOptions.sortByAmount,
        ),
      ],
    );
  }
}
