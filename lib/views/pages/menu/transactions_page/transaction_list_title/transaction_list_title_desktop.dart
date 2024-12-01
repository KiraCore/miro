import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/menu/transactions_page/transactions_filter_dropdown.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class TransactionListTitleDesktop extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;
  final TransactionsListController transactionsListController;
  final List<dynamic> activeFilters;
  final void Function(List<dynamic> activeFilters) updateFilters;

  const TransactionListTitleDesktop({
    required this.searchBarTextEditingController,
    required this.transactionsListController,
    required this.activeFilters,
    required this.updateFilters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> activeFilters = transactionsListController.typeFilters?.toList() ?? <TxMsgType>[];
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          S.of(context).transactionsPageTitle,
          style: textTheme.displayMedium!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            DateRangeDropdown(
              initialStartDateTime: transactionsListController.startDateTime,
              initialEndDateTime: transactionsListController.endDateTime,
              onDateTimeChanged: (DateTime? startDateTime, DateTime? endDateTime) {
                transactionsListController
                  ..startDateTime = startDateTime
                  ..endDateTime = endDateTime;
                BlocProvider.of<PaginatedListBloc<TxListItemModel>>(context).add(const ListReloadEvent());
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 340,
                        child: TransactionsFilterDropdown(
                          activeFilters: activeFilters,
                          onFiltersChanged: updateFilters,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: ListSearchWidget<TxListItemModel>(
                          textEditingController: searchBarTextEditingController,
                          hint: S.of(context).transactionsPageHintSearch,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
