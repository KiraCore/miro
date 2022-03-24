import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';

class SmallBalanceCheckbox extends StatefulWidget {
  const SmallBalanceCheckbox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallBalancesCheckbox();
}

class _SmallBalancesCheckbox extends State<SmallBalanceCheckbox> {
  bool selectedStatus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _updateSelectedStatus,
      child: BlocConsumer<BalanceListBloc, ListState>(
        listener: (_, ListState state) {
          if (state is ListSearchedState) {
            selectedStatus = false;
          }
        },
        builder: (_, ListState state) {
          return Row(
            children: <Widget>[
              Checkbox(
                value: selectedStatus,
                onChanged: (bool? status) => _updateSelectedStatus(),
                splashRadius: 0,
                activeColor: DesignColors.blue1_100,
                checkColor: Theme.of(context).scaffoldBackgroundColor,
                fillColor: MaterialStateProperty.all(DesignColors.gray2_100),
              ),
              const Text(
                'Hide small values',
                style: TextStyle(
                  fontSize: 13,
                  color: DesignColors.gray2_100,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updateSelectedStatus() {
    setState(() {
      selectedStatus = !selectedStatus;
    });
    BalanceListBloc balanceListBloc = BlocProvider.of<BalanceListBloc>(context);
    FilterOption<Balance> filterOption = BalancesComparator().getFilterOption(BalanceFilterOption.smallBalances);
    if (selectedStatus) {
      balanceListBloc.add(AddFilterEvent<Balance>(filterOption));
    } else {
      balanceListBloc.add(RemoveFilterEvent<Balance>(filterOption));
    }
  }
}
