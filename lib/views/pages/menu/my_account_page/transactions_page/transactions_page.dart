import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/transactions_list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_transactions.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/query_transaction_result_resp.dart';
import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_transactions.dart';
import 'package:miro/infra/services/api/query_transaction_result_service.dart';
import 'package:miro/shared/models/list/filter_option.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/pages/transactions_comparator.dart';
import 'package:miro/views/widgets/generic/prefixed_text.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';
import 'package:miro/views/widgets/kira/kira_list/kira_list.dart';
import 'package:miro/views/widgets/kira/kira_list/sortable_title.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class TransactionsPage extends StatefulWidget {
  final ScrollController parentScrollController;

  const TransactionsPage({
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsPage();
}

class _TransactionsPage extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return KiraList<TransactionObject, TransactionsListBloc>(
      shrinkWrap: true,
      listType: KiraListType.paginated,
      scrollController: widget.parentScrollController,
      backgroundColor: DesignColors.blue1_10,
      columnHeadersWidget: const _ColumnHeaders(),
      listActions: ListActions<TransactionObject>(
        sortWidgetEnabled: !ResponsiveWidget.isLargeScreen(context),
        sortOptions: TransactionsComparator().getAllSortOptions(),
        //
        filterWidgetEnabled: true,
        filterOptions: TransactionsComparator().getAllFilterOptions(),
        //
        searchWidgetEnabled: true,
        searchCallback: TransactionsComparator.filterSearch,
        //
        dateFilterWidgetEnabled: true,
        onDatePicked: _onDateFilterChanged,
      ),
      itemBuilder: (TransactionObject item) {
        if (item.txs.isEmpty) {
          return _EmptyTransactionListItem(
            transactionObject: item,
          );
        }
        return _TransactionListItem(transactionObject: item);
      },
    );
  }

  void _onDateFilterChanged(DateTime? from, DateTime? to) {
    TransactionsListBloc transactionsListBloc = BlocProvider.of<TransactionsListBloc>(context);
    FilterOption<TransactionObject> dateFilter = FilterOption<TransactionObject>(
      name: 'date',
      comparator: (TransactionObject item) => TransactionsComparator.filterByDate(item, from, to),
    );
    transactionsListBloc.add(RemoveFilterEvent<TransactionObject>(dateFilter));

    if (from != null && to != null) {
      transactionsListBloc.add(AddFilterEvent<TransactionObject>(dateFilter));
    }
  }
}

class _ColumnHeaders extends StatelessWidget {
  const _ColumnHeaders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle titleTextStyle = TextStyle(
      color: DesignColors.gray2_100,
      fontSize: 12,
    );
    return _TransactionsListItemLayout(
      height: 53,
      iconWidget: const SizedBox(),
      addressWidget: SortableTitle<TransactionObject, TransactionsListBloc>(
        label: const Text('Details', style: titleTextStyle),
        sortOption: TransactionsComparator().getSortOption(TransactionSortOption.details),
      ),
      transactionHashWidget: SortableTitle<TransactionObject, TransactionsListBloc>(
        label: const Text('Transaction hash', style: titleTextStyle),
        sortOption: TransactionsComparator().getSortOption(TransactionSortOption.hash),
      ),
      statusWidget: const SortableTitle<TransactionObject, TransactionsListBloc>(
        label: Text('Status', style: titleTextStyle),
      ),
      dateWidget: SortableTitle<TransactionObject, TransactionsListBloc>(
        label: const Text('Date', style: titleTextStyle),
        sortOption: TransactionsComparator().getSortOption(TransactionSortOption.date),
      ),
      amountWidget: SortableTitle<TransactionObject, TransactionsListBloc>(
        label: const Text('Amount', style: titleTextStyle),
        sortOption: TransactionsComparator().getSortOption(TransactionSortOption.amount),
      ),
    );
  }
}

const TextStyle kCellTextStyle = TextStyle(
  color: DesignColors.gray2_100,
  fontSize: 14,
);

class _EmptyTransactionListItem extends StatelessWidget {
  final TransactionObject transactionObject;

  const _EmptyTransactionListItem({
    required this.transactionObject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TransactionsListItemLayout(
      iconWidget: const Icon(
        Icons.error,
        color: DesignColors.blue1_100,
      ),
      addressWidget: const Text(
        'Undefined transaction',
        style: kCellTextStyle,
      ),
      transactionHashWidget: _TransactionHashWidget(
        hash: transactionObject.hash,
      ),
      statusWidget: _TransactionStatusWidget(
        key: GlobalObjectKey('${transactionObject.hash}-status'),
        hash: transactionObject.hash,
      ),
      dateWidget: Text(
        DateFormat('d MMM, h:mm a').format(DateTime.fromMillisecondsSinceEpoch(transactionObject.time * 1000)),
        style: kCellTextStyle,
      ),
      amountWidget: const Text(
        'Undefined transaction',
        style: kCellTextStyle,
      ),
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final TransactionObject transactionObject;

  const _TransactionListItem({
    required this.transactionObject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TransactionsListItemLayout(
      iconWidget: Icon(
        _getIconData(),
        color: DesignColors.blue1_100,
      ),
      addressWidget: PrefixedWidget(
        prefix: _getDetailsPrefixText(),
        child: Text(
          WalletAddress.fromBech32(transactionObject.txs.first.address).bech32Shortcut,
          style: kCellTextStyle.copyWith(
            color: DesignColors.white_100,
          ),
        ),
      ),
      transactionHashWidget: _TransactionHashWidget(
        hash: transactionObject.hash,
      ),
      statusWidget: _TransactionStatusWidget(
        key: GlobalObjectKey('${transactionObject.hash}-status'),
        hash: transactionObject.hash,
      ),
      dateWidget: Text(
        DateFormat('d MMM, h:mm a').format(DateTime.fromMillisecondsSinceEpoch(transactionObject.time * 1000)),
        style: kCellTextStyle,
      ),
      amountWidget: _getAmountTextWidget(),
    );
  }

  String _getDetailsPrefixText() {
    if (transactionObject is DepositsTransactions) {
      return 'Deposit';
    } else if (transactionObject is WithdrawsTransactions) {
      return 'Withdraw';
    }
    return 'Unknown';
  }

  IconData _getIconData() {
    if (transactionObject is DepositsTransactions) {
      return AppIcons.deposit;
    } else if (transactionObject is WithdrawsTransactions) {
      return AppIcons.withdraw;
    }
    return Icons.error;
  }

  Widget _getAmountTextWidget() {
    if (transactionObject is DepositsTransactions) {
      return Text(
        '+ ${transactionObject.txs.first.amount} ${transactionObject.txs.first.denom}',
        style: kCellTextStyle.copyWith(
          color: DesignColors.darkGreen,
        ),
      );
    } else if (transactionObject is WithdrawsTransactions) {
      return Text(
        '- ${transactionObject.txs.first.amount} ${transactionObject.txs.first.denom}',
        style: kCellTextStyle.copyWith(
          color: DesignColors.red_100,
        ),
      );
    }
    return Text(
      '${transactionObject.txs.first.amount} ${transactionObject.txs.first.denom}',
      style: kCellTextStyle.copyWith(
        color: DesignColors.gray2_100,
      ),
    );
  }
}

class _TransactionHashWidget extends StatelessWidget {
  final String hash;

  const _TransactionHashWidget({
    required this.hash,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraToolTip(
      message: hash,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              hash,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: kCellTextStyle,
            ),
          ),
          const Text(
            '...',
            style: kCellTextStyle,
          ),
          SizedBox(
            height: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hash));
                KiraToast.show('Copied transaction address to clipboard');
              },
              splashRadius: 15,
              icon: const Icon(
                AppIcons.copy,
                color: DesignColors.gray2_100,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionsListItemLayout extends StatelessWidget {
  final Widget iconWidget;
  final Widget addressWidget;
  final Widget transactionHashWidget;
  final Widget statusWidget;
  final Widget dateWidget;
  final Widget amountWidget;
  final double height;

  const _TransactionsListItemLayout({
    required this.iconWidget,
    required this.addressWidget,
    required this.transactionHashWidget,
    required this.statusWidget,
    required this.dateWidget,
    required this.amountWidget,
    this.height = 80,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: Color(0xFF343261),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _ListCell(
            child: iconWidget,
          ),
          _ListCell(
            flex: 2,
            child: addressWidget,
          ),
          _ListCell(
            flex: 2,
            child: transactionHashWidget,
          ),
          _ListCell(
            flex: 2,
            child: statusWidget,
          ),
          _ListCell(
            flex: 2,
            child: dateWidget,
          ),
          _ListCell(
            flex: 2,
            child: amountWidget,
          ),
        ],
      ),
    );
  }
}

class _ListCell extends StatelessWidget {
  final int flex;
  final Widget child;

  const _ListCell({
    required this.child,
    this.flex = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: child,
      ),
    );
  }
}

class _TransactionStatusWidget extends StatefulWidget {
  final String hash;

  const _TransactionStatusWidget({
    required this.hash,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionStatusWidgetState();
}

class _TransactionStatusWidgetState extends State<_TransactionStatusWidget> {
  late TransactionsListBloc transactionsListBloc;
  bool loadingStatus = false;

  QueryTransactionResultResp? get queryTransactionResultResp => transactionsListBloc.transactionsStatus[widget.hash];

  @override
  void initState() {
    transactionsListBloc = BlocProvider.of<TransactionsListBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (queryTransactionResultResp == null) {
      _initTransactionStatus();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StatusChip(
      value: _getStatusChipValue(),
    );
  }

  Future<void> _initTransactionStatus() async {
    _setLoadingStatus(status: true);
    try {
      QueryTransactionResultService queryTransactionResultService = globalLocator<QueryTransactionResultService>();
      QueryTransactionResultResp queryTransactionResultResp = await queryTransactionResultService.getTransactionDetails(
        widget.hash,
      );
      transactionsListBloc.transactionsStatus[widget.hash] = queryTransactionResultResp;
    } catch (e) {
      AppLogger().log(
        message: 'Cannot get transaction status for transaction ${widget.hash}',
        logLevel: LogLevel.error,
      );
    }
    _setLoadingStatus(status: false);
  }

  StatusChipValue _getStatusChipValue() {
    if (loadingStatus) {
      return StatusChipValue.loading;
    } else if (!loadingStatus && queryTransactionResultResp == null) {
      return StatusChipValue.failed;
    } else if (queryTransactionResultResp!.status == 'Success') {
      return StatusChipValue.confirmed;
    } else if (queryTransactionResultResp!.status == 'Pending') {
      return StatusChipValue.pending;
    }
    AppLogger().log(
      message: 'Unknown transaction status ${queryTransactionResultResp!.status}',
      logLevel: LogLevel.error,
    );
    return StatusChipValue.failed;
  }

  void _setLoadingStatus({required bool status}) {
    if (mounted) {
      setState(() {
        loadingStatus = status;
      });
    }
  }
}
