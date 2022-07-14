import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  final ScrollController parentScrollController;

  const BalancePage({
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Work in progress');
    // TODO(dominik): List refactor
    // return KiraList<Balance, BalanceListBloc>(
    //   scrollController: parentScrollController,
    //   shrinkWrap: true,
    //   backgroundColor: DesignColors.blue1_10,
    //   searchCallback: BalancesComparator.filterSearch,
    //   customFilterWidgets: const <Widget>[
    //     SmallBalanceCheckbox(),
    //     SizedBox(width: 15),
    //   ],
    //   sortOptions: BalanceListBloc.sortOptions,
    //   itemBuilder: (Balance item) {
    //     return BalanceListItemBuilder(
    //       key: Key(item.denom),
    //       balance: item,
    //     );
    //   },
    // );
  }
}
