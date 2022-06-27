import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallBalanceCheckbox extends StatefulWidget {
  const SmallBalanceCheckbox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallBalancesCheckbox();
}

class _SmallBalancesCheckbox extends State<SmallBalanceCheckbox> {
  bool selectedStatus = false;

  @override
  Widget build(BuildContext context) {
    // TODO(dominik): List refactor
    return const Text('Work in progress');
    // return InkWell(
    //   onTap: _updateSelectedStatus,
    //   child: BlocConsumer<BalanceListBloc, ListState>(
    //     listener: (_, ListState state) {
    //       if (state is ListSearchedState) {
    //         selectedStatus = false;
    //       }
    //     },
    //     builder: (_, ListState state) {
    //       return Row(
    //         children: <Widget>[
    //           Checkbox(
    //             value: selectedStatus,
    //             onChanged: (bool? status) => _updateSelectedStatus(),
    //             splashRadius: 0,
    //             activeColor: DesignColors.blue1_100,
    //             checkColor: Theme.of(context).scaffoldBackgroundColor,
    //             fillColor: MaterialStateProperty.all(DesignColors.gray2_100),
    //           ),
    //           const Text(
    //             'Hide small values',
    //             style: TextStyle(
    //               fontSize: 13,
    //               color: DesignColors.gray2_100,
    //             ),
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
// TODO(dominik): List refactor
// void _updateSelectedStatus() {
//   setState(() {
//     selectedStatus = !selectedStatus;
//   });
//   if (selectedStatus) {
//     BlocProvider.of<BalanceListBloc>(context).add(FilterEvent<Balance>(BalancesComparator.filterSmallBalances));
//   } else {
//     BlocProvider.of<BalanceListBloc>(context).add(FilterEvent<Balance>(BalancesComparator.clear));
//   }
// }
}
