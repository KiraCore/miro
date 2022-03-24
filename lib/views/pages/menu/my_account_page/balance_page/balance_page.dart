import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/small_balances_checkbox.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_list.dart';

class BalancePage extends StatefulWidget {
  final ScrollController parentScrollController;

  const BalancePage({
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BalancePage();
}

class _BalancePage extends State<BalancePage> {
  @override
  void didUpdateWidget(covariant BalancePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BalanceListBloc>(context).add(
      GoToPageEvent(0),
    );

    return KiraList<Balance, BalanceListBloc>(
      scrollController: widget.parentScrollController,
      shrinkWrap: true,
      listType: KiraListType.infinity,
      backgroundColor: DesignColors.blue1_10,
      listActions: ListActions<Balance>(
        searchWidgetEnabled: true,
        searchCallback: BalancesComparator.filterSearch,
        //
        sortWidgetEnabled: true,
        sortOptions: BalancesComparator().getAllSortOptions(),
        customWidget: const SmallBalanceCheckbox(),
      ),
      itemBuilder: (Balance item) {
        return BalanceListItemBuilder(
          key: Key(item.denom),
          balance: item,
        );
      },
    );
  }
}
