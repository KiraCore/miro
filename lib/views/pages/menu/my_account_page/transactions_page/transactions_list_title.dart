import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/shared/controllers/menu/my_account_page/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transactions_filter_dropdown.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionsListTitle extends StatefulWidget {
  final TransactionsListController transactionsListController;
  final Widget pageSizeDropdownWidget;

  const TransactionsListTitle({
    required this.transactionsListController,
    required this.pageSizeDropdownWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsListTitle();
}

class _TransactionsListTitle extends State<TransactionsListTitle> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> activeFilters = <dynamic>[
      ...widget.transactionsListController.directionFilters ?? <TxDirectionType>[],
      ...widget.transactionsListController.statusFilters ?? <TxStatusType>[],
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ColumnRowSwapper(
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        columnMainAxisAlignment: MainAxisAlignment.start,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DateRangeDropdown(
            initialStartDateTime: widget.transactionsListController.startDateTime,
            initialEndDateTime: widget.transactionsListController.endDateTime,
            onDateTimeChanged: (DateTime? startDateTime, DateTime? endDateTime) {
              widget.transactionsListController
                ..startDateTime = startDateTime
                ..endDateTime = endDateTime;
              BlocProvider.of<PaginatedListBloc<TxListItemModel>>(context).add(const ListReloadEvent());
            },
          ),
          if (ResponsiveWidget.isLargeScreen(context)) ...<Widget>[
            const SizedBox(width: 30),
            Expanded(
              child: TransactionsFilterDropdown(
                activeFilters: activeFilters,
                onFiltersChanged: _updateFilters,
              ),
            ),
            const SizedBox(width: 30),
            widget.pageSizeDropdownWidget,
          ] else ...<Widget>[
            const SizedBox(height: 30),
            TransactionsFilterDropdown(
              activeFilters: activeFilters,
              mobileAdditionalWidget: widget.pageSizeDropdownWidget,
              onFiltersChanged: _updateFilters,
            ),
          ],
        ],
      ),
    );
  }

  void _updateFilters(List<dynamic> activeFilters) {
    widget.transactionsListController
      ..directionFilters = activeFilters.whereType<TxDirectionType>().toList()
      ..statusFilters = activeFilters.whereType<TxStatusType>().toList();
    BlocProvider.of<PaginatedListBloc<TxListItemModel>>(context).add(const ListReloadEvent());
  }
}
