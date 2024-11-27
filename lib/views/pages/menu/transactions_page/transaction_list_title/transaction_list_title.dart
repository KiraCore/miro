import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/paginated_list/paginated_list_bloc.dart';
import 'package:miro/shared/controllers/menu/transactions_page/transactions_list_controller.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_title/transaction_list_title_desktop.dart';
import 'package:miro/views/pages/menu/transactions_page/transaction_list_title/transaction_list_title_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TransactionListTitle extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;
  final TransactionsListController transactionsListController;

  const TransactionListTitle({
    required this.searchBarTextEditingController,
    required this.transactionsListController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> activeFilters = <dynamic>[
      ...transactionsListController.typeFilters ?? <TxMsgType>[],
    ];

    return ResponsiveWidget(
      largeScreen: TransactionListTitleDesktop(
        searchBarTextEditingController: searchBarTextEditingController,
        transactionsListController: transactionsListController,
        activeFilters:  activeFilters,
          updateFilters: (List<dynamic> activeFilters) => _updateFilters(context, activeFilters),
      ),
      mediumScreen: TransactionListTitleMobile(
        searchBarTextEditingController: searchBarTextEditingController,
        transactionsListController: transactionsListController,
        activeFilters:  activeFilters,
        updateFilters: (List<dynamic> activeFilters) => _updateFilters(context, activeFilters),
      ),
    );
  }

  void _updateFilters(BuildContext context, List<dynamic> activeFilters) {
    transactionsListController.typeFilters = activeFilters.whereType<TxMsgType>().toList();
    BlocProvider.of<PaginatedListBloc<TxListItemModel>>(context).add(const ListReloadEvent());
  }
}
