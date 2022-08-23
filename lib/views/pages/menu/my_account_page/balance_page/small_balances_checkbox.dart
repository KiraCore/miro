import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/controllers/menu/my_account_page/balances_page/balances_filter_options.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class SmallBalanceCheckbox extends StatefulWidget {
  const SmallBalanceCheckbox({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmallBalancesCheckbox();
}

class _SmallBalancesCheckbox extends State<SmallBalanceCheckbox> {
  late final FiltersBloc<BalanceModel> filtersBloc = BlocProvider.of<FiltersBloc<BalanceModel>>(context);
  bool selectedStatus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: _updateSelectedStatus,
      child: BlocBuilder<FiltersBloc<BalanceModel>, AFiltersState<BalanceModel>>(
        builder: (_, AFiltersState<BalanceModel> filtersState) {
          return Row(
            children: <Widget>[
              Checkbox(
                value: selectedStatus,
                onChanged: (bool? status) => _updateSelectedStatus(),
                splashRadius: 0,
                activeColor: DesignColors.blue1_100,
                checkColor: Theme.of(context).scaffoldBackgroundColor,
                fillColor: MaterialStateProperty.all(DesignColors.blue1_100),
              ),
              const SizedBox(width: 5),
              Text(
                'Hide small balances',
                style: TextStyle(
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 12 : 13,
                  fontWeight: FontWeight.w500,
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
    if (selectedStatus) {
      filtersBloc.add(FiltersRemoveOptionEvent<BalanceModel>(BalancesFilterOptions.filterBySmallValues));
    } else {
      filtersBloc.add(FiltersAddOptionEvent<BalanceModel>(BalancesFilterOptions.filterBySmallValues));
    }
    selectedStatus = !selectedStatus;
    setState(() {});
  }
}
