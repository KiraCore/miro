import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/small_balances_checkbox.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_list.dart';

class BalancePage extends StatelessWidget {
  final ScrollController parentScrollController;

  const BalancePage({
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraList<Balance, BalanceListBloc>(
      scrollController: parentScrollController,
      shrinkWrap: true,
      backgroundColor: DesignColors.blue1_10,
      searchCallback: BalancesComparator.filterSearch,
      customFilterWidgets: const <Widget>[
        SmallBalanceCheckbox(),
        SizedBox(width: 15),
      ],
      sortOptions: BalanceListBloc.sortOptions,
      itemBuilder: (Balance item) {
        return BalanceListItemBuilder(
          key: Key(item.denom),
          balance: item,
        );
      },
    );
  }
}
